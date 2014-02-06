//
//  ACStoryboardSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"
#import "UIViewController+SegueUserInfo.h"


@implementation ACStoryboardSegueTemplate

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _destinationViewControllerIdentifier = destinationViewControllerIdentifier;
        _destinationClassName = nil;
        _destinationNibName = nil;
        _destinationBundle = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerClassName:(NSString*)className withNibName:(NSString*)nibName bundle:(NSBundle*)bundle {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _destinationViewControllerIdentifier = nil;
        _destinationClassName = className;
        _destinationNibName = nibName;
        _destinationBundle = bundle;
    }
    return self;
}

#pragma mark - Perform segue

- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController {
	Class class = [self effectiveSegueClass];
    return [[class alloc] initWithIdentifier:self.identifier source:self.viewController destination:destinationViewController];
}


- (void)perform:(id)sender {
    if (![self.viewController respondsToSelector:@selector(shouldPerformSegueWithIdentifier:sender:)] || [self.viewController shouldPerformSegueWithIdentifier:self.identifier sender:sender]) {
        [self _perform:sender];
    }
}

- (void)_perform:(id)sender {
    [self _perform:sender userInfo:nil];
}

- (void)_perform:(id)sender userInfo:(NSDictionary*)userInfo {
    [self _perform:sender userInfo:userInfo animated:YES];
}

- (UIViewController*)_perform:(id)sender userInfo:(NSDictionary*)userInfo animated:(BOOL)animated {
    
    UIViewController *destinationViewController = nil;
    
    if (self.viewController.storyboard) {
        destinationViewController = [self.viewController.storyboard instantiateViewControllerWithIdentifier:self.destinationViewControllerIdentifier];
    }
    
    // ac addition
    if (!destinationViewController) {
        Class class = NSClassFromString(self.destinationClassName);
        destinationViewController = [[class alloc] initWithNibName:self.destinationNibName bundle:self.destinationBundle];
    }

    ACStoryboardSegue *storyboardSegue = [self segueWithDestinationViewController:destinationViewController];
    
    // ac addition
    storyboardSegue.userInfo = userInfo;
    if ([self.viewController respondsToSelector:@selector(prepareForSegue:sender:userInfo:)]) {
        [self.viewController prepareForSegue:storyboardSegue sender:sender userInfo:userInfo];
    }
    
    //TODO
    destinationViewController.view; //force view load
    
	[self.viewController prepareForSegue:(UIStoryboardSegue*)storyboardSegue sender:sender];
	[storyboardSegue performAnimated:animated];
    
    // ac addition
    return destinationViewController;
}


- (Class)effectiveSegueClass {
    if (self.segueClassName) {
        return NSClassFromString(self.segueClassName);
    }
    return NSClassFromString(self.defaultSegueClassName);
}

- (NSString*)defaultSegueClassName {
    return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder*)encoder {
    if (self.identifier) {
        [encoder encodeObject:self.identifier forKey:@"UIIdentifier"];
    }
    if (self.segueClassName) {
        [encoder encodeObject:self.segueClassName forKey:@"UISegueClassName"];
    }
    if (self.destinationViewControllerIdentifier) {
        [encoder encodeObject:self.destinationViewControllerIdentifier forKey:@"UIDestinationViewControllerIdentifier"];
    }
    
    if (self.destinationClassName) {
        [encoder encodeObject:self.destinationClassName forKey:@"UIDestinationViewControllerClassName"];
    }
    if (self.destinationNibName) {
        [encoder encodeObject:self.destinationNibName forKey:@"UIDestinationViewControllerNibName"];
    }
    if (self.destinationBundle) {
        [encoder encodeObject:self.destinationBundle forKey:@"UIDestinationViewControllerBundle"];
    }
/*    if (self.performOnViewLoad) {
        [encoder encodeBool:YES forKey:@"UIPerformOnViewLoad"];
    }
*/
    
}

- (id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        _identifier = [decoder decodeObjectForKey:@"UIIdentifier"];
        _segueClassName = [decoder decodeObjectForKey:@"UISegueClassName"];
        _destinationViewControllerIdentifier = [decoder decodeObjectForKey:@"UIDestinationViewControllerIdentifier"];
        _destinationClassName = [decoder decodeObjectForKey:@"UIDestinationViewControllerClassName"];
        _destinationNibName = [decoder decodeObjectForKey:@"UIDestinationViewControllerNibName"];
        _destinationBundle = [decoder decodeObjectForKey:@"UIDestinationViewControllerBundle"];
        //_performOnViewLoad = [decoder decodeBoolForKey:@"UIPerformOnViewLoad"];
    }
    return self;
}

#pragma mark - description

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ (%@) %@ (%@)", [super description], self.identifier, self.defaultSegueClassName, self.destinationViewControllerIdentifier];
}

@end

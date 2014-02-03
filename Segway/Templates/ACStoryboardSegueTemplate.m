//
//  ACStoryboardSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"

@implementation ACStoryboardSegueTemplate

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _destinationViewControllerIdentifier = destinationViewControllerIdentifier;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerClassName:(NSString*)className withNibName:(NSString*)nibName bundle:(NSBundle*)bundle {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _destinationViewControllerClassName = className;
        _destinationViewControllerNibName = nibName;
    }
    return self;
}

#pragma mark -


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
    
    UIViewController *viewController = nil;
    
    if (self.viewController.storyboard) {
        viewController = [self.viewController.storyboard instantiateViewControllerWithIdentifier:self.destinationViewControllerIdentifier];
    }
    
    // ac addition
    if (!viewController) {
        Class class = NSClassFromString(self.destinationViewControllerClassName);
        viewController = [[class alloc] initWithNibName:self.destinationViewControllerNibName bundle:self.destinationViewControllerBundle];
    }
    
    // TODO: instanciate with Nib
    // TODO: instanciate class

    ACStoryboardSegue *storyboardSegue = [self segueWithDestinationViewController:viewController];
	[self.viewController prepareForSegue:(UIStoryboardSegue*)storyboardSegue sender:sender];
	[storyboardSegue perform];
}

- (Class)effectiveSegueClass {
    return NSClassFromString(self.defaultSegueClassName);
}

- (NSString*)defaultSegueClassName {
    return nil;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder*)encoder {
    // TODO    
}

- (id)initWithCoder:(NSCoder*)decoder {
    // TODO
    return nil;
}

#pragma mark - description

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ (%@) %@ (%@)", [super description], self.identifier, self.defaultSegueClassName, self.destinationViewControllerIdentifier];
}

@end

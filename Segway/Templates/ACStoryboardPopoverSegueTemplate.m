//
//  ACStoryboardPopoverSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardPopoverSegueTemplate.h"
#import "ACStoryboardPopoverSegue.h"

static NSString * const ACStoryboardEmbedSegueTemplateDefaultSegueClassName = @"ACStoryboardPopoverSegue";

@implementation ACStoryboardPopoverSegueTemplate

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        _anchorView = nil;
        _anchorBarButtonItem = nil;
        _permittedArrowDirections = UIPopoverArrowDirectionAny;
        _passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                     anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        _anchorView = nil;
        _anchorBarButtonItem = anchorBarButtonItem;
        _permittedArrowDirections = arrowDirections;
        _passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                            anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        _anchorView = anchorView;
        _anchorBarButtonItem = nil;
        _permittedArrowDirections = arrowDirections;
        _passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:(NSBundle *)bundle
               anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerClassName:className withNibName:nibName bundle:bundle];
    if (self) {
        _anchorView = nil;
        _anchorBarButtonItem = anchorBarButtonItem;
        _permittedArrowDirections = arrowDirections;
        _passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:(NSBundle *)bundle
                        anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerClassName:className withNibName:nibName bundle:bundle];
    if (self) {
        _anchorView = anchorView;
        _anchorBarButtonItem = nil;
        _permittedArrowDirections = arrowDirections;
        _passthroughViews = nil;
    }
    return self;
}

#pragma mark - Perform segue

- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController {
    ACStoryboardPopoverSegue *popoverSegue = (ACStoryboardPopoverSegue*)[super segueWithDestinationViewController:destinationViewController];
    popoverSegue.passthroughViews = self.passthroughViews;
    popoverSegue.permittedArrowDirections = self.permittedArrowDirections;
    popoverSegue.anchorBarButtonItem = self.anchorBarButtonItem;
    if (self.anchorView) {
        popoverSegue.anchorView = self.anchorView;
        popoverSegue.anchorRect = [self.anchorView bounds];
    }
    return popoverSegue;
}

- (NSString*)defaultSegueClassName {
        return ACStoryboardEmbedSegueTemplateDefaultSegueClassName;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder*)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeInteger:self.permittedArrowDirections forKey:@"UIPermittedArrowDirections"];
    [encoder encodeObject:self.passthroughViews forKey:@"UIPassthroughViews"];
    [encoder encodeObject:self.anchorBarButtonItem forKey:@"UIAnchorBarButtonItem"];
    [encoder encodeObject:self.anchorView forKey:@"UIAnchorView"];
}

- (id)initWithCoder:(NSCoder*)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _permittedArrowDirections = [decoder decodeIntegerForKey:@"UIPermittedArrowDirections"];
        _passthroughViews = [decoder decodeObjectForKey:@"UIPassthroughViews"];
        _anchorBarButtonItem = [decoder decodeObjectForKey:@"UIAnchorBarButtonItem"];
        _anchorView = [decoder decodeObjectForKey:@"UIAnchorView"];
    }
    return self;
}

@end

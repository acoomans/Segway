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

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        self.anchorView = nil;
        self.anchorBarButtonItem = nil;
        self.permittedArrowDirections = UIPopoverArrowDirectionAny;
        self.passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                     anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        self.anchorView = nil;
        self.anchorBarButtonItem = anchorBarButtonItem;
        self.permittedArrowDirections = arrowDirections;
        self.passthroughViews = nil;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                            anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        self.anchorView = anchorView;
        self.anchorBarButtonItem = nil;
        self.permittedArrowDirections = arrowDirections;
        self.passthroughViews = nil;
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
        self.anchorView = nil;
        self.anchorBarButtonItem = anchorBarButtonItem;
        self.permittedArrowDirections = arrowDirections;
        self.passthroughViews = nil;
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
        self.anchorView = anchorView;
        self.anchorBarButtonItem = nil;
        self.permittedArrowDirections = arrowDirections;
        self.passthroughViews = nil;
    }
    return self;
}


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
    // TODO
}

- (id)initWithCoder:(NSCoder*)decoder {
    // TODO
    return nil;
}

@end

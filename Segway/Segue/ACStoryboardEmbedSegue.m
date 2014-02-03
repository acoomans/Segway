//
//  ACStoryboardEmbedSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardEmbedSegue.h"
#import <UIKit/UIKit.h>

@implementation ACStoryboardEmbedSegue

#pragma mark - Perform segue

- (void)perform {
    
    if (!self.containerView) {
        // UIKit uses a NSAssertionHandler, we'll use an exception instead
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"containerView is required."
                                     userInfo:nil];
    }
    
    if (self.containerView.subviews.count != 0) {
        // UIKit uses a NSAssertionHandler, we'll use an exception instead
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"There are unexpected subviews in the container view. Perhaps the embed segue has already fired once or a subview was added programmatically?"
                                     userInfo:nil];
    }
    
    [self.sourceViewController addChildViewController:self.destinationViewController];
    [self.containerView addSubview:self.destinationViewController.view];
    self.destinationViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; // 0x12
    
    if (![self.destinationViewController.view translatesAutoresizingMaskIntoConstraints]) {
        NSDictionary *bindings = NSDictionaryOfVariableBindings(@"childView", self.destinationViewController.view, nil);
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:0 views:bindings]];
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[childView]|" options:0 metrics:0 views:bindings]];
    }
    
    if (self.containerView) {
        self.destinationViewController.view.frame = self.containerView.bounds;
    }
    
    [self.destinationViewController didMoveToParentViewController:self.sourceViewController];
}

@end

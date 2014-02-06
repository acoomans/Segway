//
//  ACStoryboardPopoverSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardPopoverSegue.h"
#import "UIPopoverController+SelfRetained.h"
#import "UIViewController+SourceViewController.h"


@interface ACStoryboardPopoverSegue ()
@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation ACStoryboardPopoverSegue

#pragma mark - Properties

- (UIPopoverController*)popoverController {
    
    if (!_popoverController) {
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:self.destinationViewController];
        _popoverController.passthroughViews = self.passthroughViews;
        _popoverController.retainsSelfWhilePresented = YES;
    }
    return _popoverController;
}

#pragma mark - Perform segue

- (void)performAnimated:(BOOL)animated {
    
    [self.destinationViewController ac_setSourceViewControllerIfPresentedViaPopoverSegue:self.sourceViewController];
    
    if (self.anchorBarButtonItem) {
        [self.popoverController presentPopoverFromBarButtonItem:self.anchorBarButtonItem permittedArrowDirections:self.permittedArrowDirections animated:animated];
        
    } else if (self.anchorView) {
        [self.popoverController presentPopoverFromRect:self.anchorRect inView:self.anchorView.superview permittedArrowDirections:self.permittedArrowDirections animated:animated];
        
    } else {
        
        // UIKit uses a NSAssertionHandler, we'll use an exception instead
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:[NSString stringWithFormat:@"%@ must be presented from a bar button item or a view.", self.popoverController]
                                     userInfo:nil];

    }
}

@end

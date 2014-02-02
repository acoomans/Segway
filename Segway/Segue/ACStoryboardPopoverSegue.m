//
//  ACStoryboardPopoverSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardPopoverSegue.h"
#import "UIPopoverController+SelfRetained.h"


@interface ACStoryboardPopoverSegue ()
@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation ACStoryboardPopoverSegue

- (UIPopoverController*)popoverController {
    
    if (!_popoverController) {
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:self.destinationViewController];
        _popoverController.passthroughViews = self.passthroughViews;
        
        self.popoverController.retainsSelfWhilePresented = YES; // hack to retain the popover (_setRetainsSelfWhilePresented in UIKit)
    }
    return _popoverController;
}

- (void)perform {
    
    //[self.destinationViewController _setSourceViewControllerIfPresentedViaPopoverSegue:self.sourceViewController]; // not available
    
    if (self.anchorBarButtonItem) {
        [self.popoverController presentPopoverFromBarButtonItem:self.anchorBarButtonItem permittedArrowDirections:self.permittedArrowDirections animated:YES];
        
    } else if (self.anchorView) {
        [self.popoverController presentPopoverFromRect:self.anchorRect inView:self.anchorView.superview permittedArrowDirections:self.permittedArrowDirections animated:YES];
        
    } else {
        
        // UIKit uses a NSAssertionHandler, we'll use an exception instead
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:[NSString stringWithFormat:@"%@ must be presented from a bar button item or a view.", self.popoverController]
                                     userInfo:nil];

    }
}

@end

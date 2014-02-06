//
//  ACStoryboardModalSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardModalSegue.h"

@implementation ACStoryboardModalSegue

#pragma mark - Perform segue

- (void)performAnimated:(BOOL)animated {
    if (!self.useDefaultModalPresentationStyle) {
        self.destinationViewController.modalPresentationStyle = self.modalPresentationStyle;
    }
    
    if (!self.useDefaultModalTransitionStyle) {
        self.destinationViewController.modalTransitionStyle = self.modalTransitionStyle;
    }
    
    // UIKit uses the deprecated presentViewController:animated:, we use the newer method
    [self.sourceViewController presentViewController:self.destinationViewController animated:(animated && self.animates) completion:nil];
}

@end

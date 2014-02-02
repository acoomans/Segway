//
//  UIPopoverController+SelfRetained.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIPopoverController+SelfRetained.h"
#import <objc/runtime.h>

static char const * const UIPopoverControllerRetainedSelfKey = "UIPopoverControllerRetainedSelfKey";

@implementation UIPopoverController (SelfRetained)

- (BOOL)retainsSelfWhilePresented {
    return (self.retainedSelf != nil);
}

- (void)setRetainsSelfWhilePresented:(BOOL)retainsSelfWhilePresented {
    if (retainsSelfWhilePresented) {
        self.retainedSelf = self;
        self.delegate = self;
    } else {
        self.retainedSelf = nil;
        self.delegate = nil;
    }
}

- (UIPopoverController*)retainedSelf {
    return objc_getAssociatedObject(self, UIPopoverControllerRetainedSelfKey);
}

- (void)setRetainedSelf:(UIPopoverController*)retainedSelf {
    objc_setAssociatedObject(self, UIPopoverControllerRetainedSelfKey, retainedSelf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.retainsSelfWhilePresented = NO;
}

@end

//
//  UIPopoverController+SelfRetained.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIPopoverController+SelfRetained.h"
#import <objc/runtime.h>
#import "swizzling.h"

static char const * const UIPopoverControllerRetainedSelfKey = "UIPopoverControllerRetainedSelfKey";

@implementation UIPopoverController (SelfRetained)

#pragma mark - Load

+ (void)load {
    MethodSwizzle(self, @selector(dismissPopoverAnimated:), @selector(ac_override_dismissPopoverAnimated:));
}

#pragma mark - Properties

- (BOOL)retainsSelfWhilePresented {
    return [objc_getAssociatedObject(self, UIPopoverControllerRetainedSelfKey) boolValue];
}

- (void)setRetainsSelfWhilePresented:(BOOL)retainsSelfWhilePresented {
    
    if (retainsSelfWhilePresented && ![objc_getAssociatedObject(self, UIPopoverControllerRetainedSelfKey) boolValue]) {
        [self retain];
        self.delegate = self;
        objc_setAssociatedObject(self, UIPopoverControllerRetainedSelfKey, @(retainsSelfWhilePresented), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    } else if (!retainsSelfWhilePresented && [objc_getAssociatedObject(self, UIPopoverControllerRetainedSelfKey) boolValue]) {
        [self release];
        objc_setAssociatedObject(self, UIPopoverControllerRetainedSelfKey, @(retainsSelfWhilePresented), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.retainsSelfWhilePresented = NO;
}

- (void)ac_override_dismissPopoverAnimated:(BOOL)animated {
    self.retainsSelfWhilePresented = NO;
    [self ac_override_dismissPopoverAnimated:animated];
}

/*
- (void)dealloc {
    [super dealloc];
    // test if really deallocated
}
*/

@end

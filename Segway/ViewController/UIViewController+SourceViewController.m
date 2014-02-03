//
//  UIViewController+SourceViewController.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIViewController+SourceViewController.h"
#import <objc/runtime.h>
#import "UIViewController+SourceViewController.h"
#import "swizzling.h"


static char const * const UIViewControllerSourceViewControllerIfPresentedViaPopoverSegueKey = "UIViewControllerSourceViewControllerIfPresentedViaPopoverSegueKey";
static char const * const UIViewControllerModalSourceViewControllerKey = "UIViewControllerModalSourceViewControllerKey";

@implementation UIViewController (SourceViewController)

#pragma mark - Load

+ (void)load {
    MethodSwizzle(self, @selector(presentViewController:animated:completion:), @selector(ac_override_presentViewController:animated:completion:));
}

#pragma mark - Presenting a modal view controller

- (void)ac_override_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    viewControllerToPresent.ac_modalSourceViewController = self;
    [self ac_override_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - Properties

- (UIViewController*)ac_sourceViewControllerIfPresentedViaPopoverSegue {
    return objc_getAssociatedObject(self, UIViewControllerSourceViewControllerIfPresentedViaPopoverSegueKey);
}

- (void)ac_setSourceViewControllerIfPresentedViaPopoverSegue:(UIViewController*)sourceViewControllerIfPresentedViaPopoverSegue {
    objc_setAssociatedObject(self, UIViewControllerSourceViewControllerIfPresentedViaPopoverSegueKey, sourceViewControllerIfPresentedViaPopoverSegue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController*)ac_modalSourceViewController {
    return objc_getAssociatedObject(self, UIViewControllerModalSourceViewControllerKey);
}

- (void)ac_setModalSourceViewController:(UIViewController*)ac_modalSourceViewController {
    objc_setAssociatedObject(self, UIViewControllerModalSourceViewControllerKey, ac_modalSourceViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

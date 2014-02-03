//
//  UIViewController+SourceViewController.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SourceViewController)

@property (nonatomic, assign, setter = ac_setSourceViewControllerIfPresentedViaPopoverSegue:) UIViewController *ac_sourceViewControllerIfPresentedViaPopoverSegue;  // _sourceViewControllerIfPresentedViaPopoverSegue

@property (nonatomic, assign, setter = ac_setModalSourceViewController:) UIViewController *ac_modalSourceViewController;                                            // _modalSourceViewController

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_override_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

@end

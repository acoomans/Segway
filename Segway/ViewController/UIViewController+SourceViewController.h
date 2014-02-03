//
//  UIViewController+SourceViewController.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SourceViewController)

@property (nonatomic, assign, setter = ac_setSourceViewControllerIfPresentedViaPopoverSegue:) UIViewController *ac_sourceViewControllerIfPresentedViaPopoverSegue;

@property (nonatomic, assign, setter = ac_setModalSourceViewController:) UIViewController *ac_modalSourceViewController;

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

@end

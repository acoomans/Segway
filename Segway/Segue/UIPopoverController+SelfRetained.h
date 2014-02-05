//
//  UIPopoverController+SelfRetained.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPopoverController (SelfRetained) <UIPopoverControllerDelegate>

@property (nonatomic, assign) BOOL retainsSelfWhilePresented;

// swizzled with dismissPopoverAnimated:
- (void)ac_override_dismissPopoverAnimated:(BOOL)animated;

@end




//
//  UIViewController+Popover.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO: do something to release the popover

@interface UIViewController (Popover)

@property (nonatomic, strong) UIPopoverController *popoverViewController;

@end

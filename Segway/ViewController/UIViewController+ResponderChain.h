//
//  UIViewController+ResponderChain.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ResponderChain)

- (UIViewController*)ac_nextViewControllerInResponderChain;
- (BOOL)ac_isViewController;

@end

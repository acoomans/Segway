//
//  UIResponder+ResponderChain.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (ResponderChain)

- (UIResponder*)ac_nextViewControllerInResponderChain;
- (BOOL)ac_isViewController;

@end

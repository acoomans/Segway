//
//  UIResponder+ResponderChain.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIResponder+ResponderChain.h"

@implementation UIResponder (ResponderChain)

- (UIResponder*)ac_nextViewControllerInResponderChain {
    
    UIResponder *responder = self.nextResponder;
    
    if ([responder ac_isViewController]) {
        return responder;
    }
    return [responder ac_nextViewControllerInResponderChain];
}

- (BOOL)ac_isViewController {
    return NO;
}

@end

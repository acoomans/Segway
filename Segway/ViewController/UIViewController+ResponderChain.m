//
//  UIViewController+ResponderChain.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIViewController+ResponderChain.h"
#import "UIResponder+ResponderChain.h"
#import "UIViewController+SourceViewController.h"

@implementation UIViewController (ResponderChain)

- (UIViewController*)ac_nextViewControllerInResponderChain {
    
    if (self.ac_sourceViewControllerIfPresentedViaPopoverSegue) {
        return self.ac_sourceViewControllerIfPresentedViaPopoverSegue;
    }
    
    if (self.ac_modalSourceViewController) {
        return self.ac_modalSourceViewController;
    }
    
    return (UIViewController*)[super ac_nextViewControllerInResponderChain];
}

- (BOOL)ac_isViewController {
    return YES;
}

@end

//
//  ACStoryboardUnwindSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardUnwindSegueTemplate.h"
#import "UIViewController+ResponderChain.h"
#import "UIViewController+Popover.h"
#import "UIViewController+SourceViewController.h"


@implementation ACStoryboardUnwindSegueTemplate

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString*)identifier action:(NSString *)action {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:nil];
    if (self) {
        _action = action;
    }
    return self;
}

#pragma mark - Perform segue

- (void)_perform:(id)sender {
    
    if (!self.action) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Invalid parameter not satisfying: [self action] != NULL"
                                     userInfo:nil];
    }
    
    SEL selector = NSSelectorFromString(self.action);
    id target = [self _unwindTargetForSelector:selector withSender:sender];
    if (target) {
        
        UIViewController *executor = [self _unwindExecutorForTarget:target];
        
        if (!executor) {
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:[NSString stringWithFormat:@"Could not find a view controller to execute unwinding for %@", self.action]
                                         userInfo:nil];
        }
        
        UIStoryboardSegue *segue = [executor segueForUnwindingToViewController:target
                                                            fromViewController:self.viewController
                                                                    identifier:self.identifier];
        
        if (segue) {
            [self.viewController prepareForSegue:segue sender:sender];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector withObject:segue];
#pragma clang diagnostic pop
            
            [segue perform];
        }
    }
}

- (UIViewController*)_unwindExecutorForTarget:(UIViewController*)target {
    
    if (target.ac_modalSourceViewController) {
        return target.ac_modalSourceViewController;
    }
    
    if (target.ac_sourceViewControllerIfPresentedViaPopoverSegue) {
        return target.ac_sourceViewControllerIfPresentedViaPopoverSegue;
    }
 
    return target.parentViewController;
}

- (UIViewController*)_unwindTargetForSelector:(SEL)selector withSender:(id)sender {
    
    //Note: not sure of this code
    
    UIViewController *rax = [self.viewController ac_nextViewControllerInResponderChain];
    UIViewController *r13 = nil;
    
    while (true) {
        
        r13 = rax;
        rax = nil;
        
        do {
            if (rax || !r13) {
                return rax;
            }
            
            rax = [r13 viewControllerForUnwindSegueAction:selector fromViewController:self.viewController withSender:sender];
        
        } while (rax);
        
        
        rax = [r13 ac_nextViewControllerInResponderChain];
    }
}

@end

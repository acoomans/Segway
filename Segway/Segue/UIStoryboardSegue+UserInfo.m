//
//  UIStoryboardSegue+UserInfo.m
//  Segway
//
//  Created by Arnaud Coomans on 02/05/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import "UIStoryboardSegue+UserInfo.h"
#import "UIViewController+SegueUserInfo.h"
#import <objc/runtime.h>

static char const * const UIViewControllerSegueUserInfoKey = "UIViewControllerSegueUserInfoKey";

@implementation UIStoryboardSegue (UserInfo)

#pragma mark - properties

- (NSDictionary*)userInfo {
    return objc_getAssociatedObject(self, UIViewControllerSegueUserInfoKey);
}

- (void)setUserInfo:(NSDictionary*)segueUserInfo {
    objc_setAssociatedObject(self, UIViewControllerSegueUserInfoKey, segueUserInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

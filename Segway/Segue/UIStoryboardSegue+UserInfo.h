//
//  UIStoryboardSegue+UserInfo.h
//  Segway
//
//  Created by Arnaud Coomans on 02/05/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboardSegue (UserInfo)

/** Application-specific user info that can be attached to the segue.
 */
@property (nonatomic, strong) NSDictionary *userInfo;

@end

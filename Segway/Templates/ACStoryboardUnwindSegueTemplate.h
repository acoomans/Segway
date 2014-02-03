//
//  ACStoryboardUnwindSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"

@interface ACStoryboardUnwindSegueTemplate : ACStoryboardSegueTemplate

@property(copy, nonatomic) NSString *action;

- (instancetype)initWithIdentifier:(NSString*)identifier action:(NSString*)action;

- (void)_perform:(id)sender;

- (UIViewController*)_unwindExecutorForTarget:(UIViewController*)target;
- (UIViewController*)_unwindTargetForSelector:(SEL)selector withSender:(id)sender;

@end

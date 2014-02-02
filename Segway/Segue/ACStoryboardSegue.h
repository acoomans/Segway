//
//  ACStoryboardSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACStoryboardSegue : NSObject

+ (instancetype)segueWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination performHandler:(void (^)(void))performHandler;

@property (readonly, nonatomic, copy) NSString *identifier;
@property (readonly, nonatomic, strong) UIViewController *destinationViewController;
@property (readonly, nonatomic, strong) UIViewController *sourceViewController;
@property (copy, nonatomic) void(^performHandler)();

- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination;

- (void)perform;

@end

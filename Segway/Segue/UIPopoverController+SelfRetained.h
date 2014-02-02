//
//  UIPopoverController+SelfRetained.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO: reimplement without ARC or any other cleaner way

@interface UIPopoverController (SelfRetained) <UIPopoverControllerDelegate>
@property (nonatomic, assign) BOOL retainsSelfWhilePresented;
@property (nonatomic, strong) UIPopoverController *retainedSelf;
@end




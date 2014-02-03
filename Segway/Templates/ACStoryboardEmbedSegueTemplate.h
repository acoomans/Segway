//
//  ACStoryboardEmbedSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"

@interface ACStoryboardEmbedSegueTemplate : ACStoryboardSegueTemplate

@property (nonatomic, strong) UIView *containerView;

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                     containerView:(UIView*)containerView;

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
                     containerView:(UIView*)containerView;

@end

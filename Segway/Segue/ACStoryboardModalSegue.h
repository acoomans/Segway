//
//  ACStoryboardModalSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"

@interface ACStoryboardModalSegue : ACStoryboardSegue

@property (nonatomic) BOOL animates;
@property (nonatomic) UIModalTransitionStyle modalTransitionStyle;
@property (nonatomic) UIModalPresentationStyle modalPresentationStyle;
@property (nonatomic) BOOL useDefaultModalTransitionStyle;
@property (nonatomic) BOOL useDefaultModalPresentationStyle;

@end

//
//  ACStoryboardPopoverSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"

@interface ACStoryboardPopoverSegue : ACStoryboardSegue

@property (nonatomic, readonly, strong) UIPopoverController *popoverController;

@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;
@property (nonatomic, copy) NSArray *passthroughViews;

@property (nonatomic, strong) UIBarButtonItem *anchorBarButtonItem;
@property (nonatomic, strong) UIView *anchorView;
@property (nonatomic, assign) struct CGRect anchorRect;

- (void)perform;

@end

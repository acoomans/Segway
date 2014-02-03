//
//  ACStoryboardPopoverSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"


//NOTE: unwinding seems broken with popover

@interface ACStoryboardPopoverSegueTemplate : ACStoryboardSegueTemplate

@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;
@property (nonatomic, copy) NSArray *passthroughViews;

@property (nonatomic, strong) UIBarButtonItem *anchorBarButtonItem;
@property (nonatomic, strong) UIView *anchorView;

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
               anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                        anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;


- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
               anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
                        anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;
    
@end

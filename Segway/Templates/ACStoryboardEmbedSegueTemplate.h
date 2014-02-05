//
//  ACStoryboardEmbedSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"

/** A template for embed segues.
 */

@interface ACStoryboardEmbedSegueTemplate : ACStoryboardSegueTemplate

/** @name Properties */

/** A container view for the child view controller's view.
 */
@property (nonatomic, strong) UIView *containerView;


/** @name Initialization */

/** Initialize with a storyboard ID and a container view.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                     containerView:(UIView*)containerView;

/** Initialize with a class and Nib name, and a container view.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
                     containerView:(UIView*)containerView;

@end

//
//  ACStoryboardPopoverSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"

/** A template for popover segues.
 *
 * NOTE: unwinding is broken with popovers
 */

@interface ACStoryboardPopoverSegueTemplate : ACStoryboardSegueTemplate

/** @name Properties */

/** The direction of the popover’s arrow.
 */
@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;

/** An array of views that the user can interact with while the popover is visible.
 */
@property (nonatomic, copy) NSArray *passthroughViews;

/** The bar button item on which to anchor the popover.
 */
@property (nonatomic, strong) UIBarButtonItem *anchorBarButtonItem;

/** The view containing the anchor rectangle for the popover.
 */
@property (nonatomic, strong) UIView *anchorView;


/** @name Initialization */


/** Initialize with a storyboard ID and an anchor BarButtonItem.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
               anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

/** Initialize with a storyboard ID and a anchor view.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier
                        anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

/** Initialize with a class and Nib name, and an anchor BarButtonItem.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
               anchorBarButtonItem:(UIBarButtonItem *)anchorBarButtonItem
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

/** Initialize with a class and Nib name, and a anchor view.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier
destinationViewControllerClassName:(NSString *)className
                       withNibName:(NSString *)nibName
                            bundle:bundle
                        anchorView:(UIView *)anchorView
          permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;
    
@end

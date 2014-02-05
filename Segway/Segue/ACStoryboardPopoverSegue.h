//
//  ACStoryboardPopoverSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"

/** A popover segue.
 */

@interface ACStoryboardPopoverSegue : ACStoryboardSegue

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

/** The rectangle in view at which to anchor the popover window.
 */
@property (nonatomic, assign) struct CGRect anchorRect;

/** The popover controller.
 */
@property (nonatomic, readonly, strong) UIPopoverController *popoverController;





@end

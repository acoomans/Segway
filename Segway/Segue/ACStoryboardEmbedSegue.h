//
//  ACStoryboardEmbedSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"


/** An embed segue.
 */

@interface ACStoryboardEmbedSegue : ACStoryboardSegue

/** @name Properties */

/** A container view for the child view controller's view.
 */
@property (nonatomic, weak) UIView *containerView;

@end

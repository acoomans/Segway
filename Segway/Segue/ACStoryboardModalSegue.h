//
//  ACStoryboardModalSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"

/** A modal segue.
 */

@interface ACStoryboardModalSegue : ACStoryboardSegue

/** @name Properties */

/** Animate the presentation.
 */
@property (nonatomic) BOOL animates;

/** The transition style to use when presenting the destination view controller.
 */
@property (nonatomic) UIModalTransitionStyle modalTransitionStyle;

/** The presentation style to use when presenting modally the destination view controller.
 */
@property (nonatomic) UIModalPresentationStyle modalPresentationStyle;

/** Use the default transition style when presenting the destination view controller.
 */
@property (nonatomic) BOOL useDefaultModalTransitionStyle;

/** Use the default presentation style when presenting modally the destination view controller.
 */
@property (nonatomic) BOOL useDefaultModalPresentationStyle;

@end

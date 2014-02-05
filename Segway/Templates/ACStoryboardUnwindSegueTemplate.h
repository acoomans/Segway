//
//  ACStoryboardUnwindSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"


/** A template for unwind segues.
 *
 * ACStoryboardUnwindSegueTemplate does not instanciate any segue, but rather unwind to the first UIViewController implementing a selector with action name.
 */

@interface ACStoryboardUnwindSegueTemplate : ACStoryboardSegueTemplate

/** @name Properties */

/** The name of the action.
 * @param action The name of the selector to unwind to.
 * @discussion When performing, this template will unwind to the first next responding UIViewController that implements the action selector.
 */
@property(copy, nonatomic) NSString *action;

/** @name Initialization */

/** Initialize with an action name.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier action:(NSString*)action;

@end

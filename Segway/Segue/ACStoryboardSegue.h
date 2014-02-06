//
//  ACStoryboardSegue.h
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** ACStoryboardSegue is a public re-implementation of the UIStoryboardSegue class, representing a segue.
 *
 * A ACStoryboardSegue object is responsible for performing the visual transition between two view controllers. In addition, segue objects are used to prepare for the transition from one view controller to another. Segue objects contain information about the view controllers involved in a transition. When a segue is triggered, but before the visual transition occurs, the current view controller’s prepareForSegue:sender: method is called so that it can pass any needed data to the view controller that is about to be displayed.
 *
 * The ACStoryboardSegue class supports the standard visual transitions available in UIKit. You can also subclass to define custom transitions between the view controllers in your storyboard file.
 *
 * Unlike UIStoryboardSegue, the storyboard runtime cannot create them when it must perform a segue between two view controllers. You must create segue objects directly. You initiate a segue programmatically using the performSegueWithIdentifier:sender: method of UIViewController.
 *
 * # Subclassing
 * You can subclass ACStoryboardSegue in situations where you want to provide a custom transition between view controllers in your application. 
 * To do so, give your subclass name to the ACStoryboardSegueTemplate's segueClassName property.
 *
 * # Methods to Override
 * For custom segues, the main method you need to override is the perform method. This method is called when it is time to perform the visual transition from the view controller in sourceViewController to the view controller in destinationViewController. 
 *
 * If you need to initialize any variables in your custom segue subclass, you can also override the initWithIdentifier:source:destination: method and initialize them in your custom implementation. You may want to subclass ACStoryboardSegueTemplate as well. See the documentation of ACStoryboardSegueTemplate for more details.
 * 
 * # Alternatives to Subclassing
 * If your segue does not need to store additional information or provide anything other than a perform method, consider using the segueWithIdentifier:source:destination:performHandler: method instead.
 */
@interface ACStoryboardSegue : NSObject

/** @name Creating a Custom Segue */

/** Creates a segue that calls a block to perform the segue transition.
 * @param identifier The identifier you want to associate with this particular instance of the segue. You can use this identifier to differentiate one type of segue from another at runtime.
 * @param source The view controller visible at the start of the segue.
 * @param destination The view controller to display after the completion of the segue.
 * @param performHandler A block to be called when the segue’s perform method is called.
 * @return An initialized segue object.
 * @discussion You use this method as an alternative to creating a subclass. Your perform handler should do all of the work necessary to transition between the source and destination view controllers, exactly as if you were implementing the perform method.
 */
+ (instancetype)segueWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination performHandler:(void (^)(void))performHandler;

/** @name Accessing the Segue Attributes */

/** The identifier for the segue object.
 * @discussion An identifier is a string that your application uses to distinguish one segue from another. For example, if you have a source view controller that can segue to two or more different destination view controllers, you would assign different identifiers to each segue so that the source view controller’s prepareForSegue:sender: method could tell them apart and prepare each segue appropriately.
 */
@property (readonly, nonatomic, copy) NSString *identifier;


/** The destination view controller for the segue.
 * @discussion This property contains the view controller whose contents should be displayed at the end of the segue.
 */
@property (readonly, nonatomic, strong) UIViewController *destinationViewController;

/** The source view controller for the segue.
 * @discussion This property contains the view controller whose contents are displayed at the beginning of the segue.
 */
@property (readonly, nonatomic, strong) UIViewController *sourceViewController;

/** The perform handler for the segue.
 * @discussion A block to be called when the segue’s perform method is called.
 */
@property (copy, nonatomic) void(^performHandler)();


/** Application-specific user info that can be attached to the segue.
 */
@property (copy, nonatomic) NSDictionary *userInfo;


/** @name Initializing a Storyboard Segue */

/** Initializes and returns a storyboard segue object for use in performing a segue.
 * @param identifier The identifier you want to associate with this particular instance of the segue. You can use this identifier to differentiate one type of segue from another at runtime.
 * @param source The view controller visible at the start of the segue.
 * @param destination The view controller to display after the completion of the segue.
 * @return An initialized segue object.
 * @discussion This method is the designated initializer for segue objects. If you subclass ACStoryboardSegue, you can override this method and perform any custom initialization in your implementation. Your implementation should call super first and then proceed if that method does not return nil.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination;

/** @name Performing the Segue */

/** Performs the visual transition for the segue.
 * @discussion Subclasses override this method and use it to perform the animations from the views in sourceViewController to the views in destinationViewController. Typically, you would use UIKit or Core Animation to set up an animation from one set of views to the next. For more complex animations, you might take a snapshot image of the two view hierarchies and manipulate the images instead of the actual view objects.
 * 
 * Regardless of how you perform the animation, at the end of it, you are responsible for installing the destination view controller (and its views) in the right place so that it can handle events. For example, if you were to implement a custom modal transition, you might perform your animations using snapshot images and then at the end call the presentModalViewController:animated: method (with animations disabled) to set up the appropriate modal relationship between the source and destination view controllers.
 */
- (void)perform;

//TODO
- (void)performAnimated:(BOOL)animated;

@end

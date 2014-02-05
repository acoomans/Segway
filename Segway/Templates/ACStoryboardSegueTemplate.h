//
//  ACStoryboardSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ACStoryboardSegue;


/** ACStoryboardSegueTemplate is a public re-implementation of the private UIStoryboardSegueTemplate class, representing a template for segues.
 *
 * In UIKit, UIStoryboardSegueTemplate can only be created in a storyboard. Segway's ACStoryboardSegueTemplate can be created programmatically, removing the need of storyboards for performing segues.
 *
 * # Registering a template with a storyboard
 * ACStoryboardSegueTemplate are first initialized and registered with a source UIViewController.
 * Then, when performSegueWithIdentifier:sender: is called on that source UIViewController, a ACStoryboardSegue is initialized by the template and passed to the UIViewController's prepareForSegue:sender: method, if implemented.
 * Finally, the segue performs the transition between the source and destination view controllers.
 *
 * ACStoryboardSegueTemplate is initialized with an identifier, for use with the performSegueWithIdentifier:sender: method.
 *
 * Like UIStoryboardSegueTemplate, ACStoryboardSegueTemplate can use a view controller's storyboard ID to instanciate a UIViewController. However, UIStoryboardSegueTemplate can also instanciate an UIViewController from a class and/or a Nib instead.
 *
 *
 * # Subclassing
 * You would subclass ACStoryboardSegueTemplate if you want a custom ACStoryboardSegue that takes arguments. Add corresponding properties, and override the defaultSegueClassName method.
 *
 * If you don't need special arguments in your segue subclass, you can simply use ACStoryboardSegueTemplate and give the ACStoryboardSegue subclass name to the ACStoryboardSegueTemplate's segueClassName property.
 */

@interface ACStoryboardSegueTemplate : NSObject //TODO: <NSCoding>

/** @name Properties */

//@property (nonatomic, assign) BOOL performOnViewLoad; // not implemented

@property (nonatomic, weak) UIViewController *viewController;

/** The identifier of performed segues.
 * @discussion The identifier is used when calling UIViewController's performSegueWithIdentifier:sender: method.
 */
@property (readonly, nonatomic, copy) NSString *identifier;

/** The identifier of the destination UIViewController in a storyboard.
 * @discussion If a destination UIViewController can be instanciated with the destinationViewControllerIdentifier from the same storyboard as the source view controller, that destination UIViewController will be used for performing the segue. If not, the ACStoryboardSegueTemplate will try to instanciate with a class (see destinationClassName).
 */
@property (readonly, nonatomic, copy) NSString *destinationViewControllerIdentifier;

/** The class of the destination UIViewController.
 * @discussion If a destination UIViewController could not be instanciated from a storyboard (see destinationViewControllerIdentifier), ACStoryboardSegueTemplate will try to instanciate a class with destinationClassName and a Nib with destinationNibName in bundle destinationBundle.
 */
@property (readonly, nonatomic, copy) NSString *destinationClassName;

/** The Nib of the destination UIViewController.
 */
@property (readonly, nonatomic, copy) NSString *destinationNibName;

/** The bundle of the Nib of the destination UIViewController.
 */
@property (readonly, nonatomic, copy) NSBundle *destinationBundle;

/** The name of segue class to use when performing.
 * @discussion This can used for sublcassing ACStoryboardSegue.
 */
@property (nonatomic, copy) NSString *segueClassName;

/** @name Initialization */

/** Initialize with a storyboard ID.
 * @param identifier Segue Identifier.
 * @param destinationViewControllerIdentifier A storyboard ID for the destination UIViewController. That view controller has to be defined in the same storyboard as the source view controller.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier;

/** Initialize with a class and Nib name.
 * @param className Name of the destination UIViewController class to instanciate.
 * @param nibName Name of a Nib to use when initializing the destination view controller.
 * @param bundle Bundle containing the Nib designed by nibName.
 */
- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerClassName:(NSString*)className withNibName:(NSString*)nibName bundle:(NSBundle*)bundle;

- (void)perform:(id)sender;
- (void)_perform:(id)sender;

- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController;

- (Class)effectiveSegueClass;

/** @name Subclassing */

/** The name of the segue class.
 * @discussion Override this method if you subclass ACStoryboardSegueTemplate.
 */
- (NSString*)defaultSegueClassName;

@end

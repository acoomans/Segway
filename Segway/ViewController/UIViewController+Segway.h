//
//  UIViewController+Segway.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACStoryboardSegueTemplate, ACStoryboardSegue;


/** UIViewController (Segway) is a category to manage segues.
 *
 * This category let you programmatically register a ACStoryboardSegueTemplate with a UIViewController.
 */

@interface UIViewController (Segway)

@property (nonatomic, copy) NSArray *ac_storyboardSegueTemplates;                           // storyboardSegueTemplates

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier;         // _segueTemplateWithIdentifier:

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_override_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender;

/** Initiates the segue with the specified identifier from the view controller’s storyboard file.
 * @param identifier The string that identifies the segue.
 * @param sender The object that you want to use to initiate the segue. This object is made available for informational purposes during the actual segue.
 * @param userInfo The user information dictionary stores any additional objects that source view controller may use during prepareForSegue:sender:.
 * @exception NSInvalidArgumentException An exception is thrown if no template was found for the identifier.
 * @discussion If the segue is initiated through a ACStoryboardTemplate registered with registerSegueTemplate:, UIViewController's prepareForSegue:sender: and prepareForSegue:sender:userInfo: methods will be called if implemented.
 *
 *  **Note:** This method will work for both ACStoryboardSegue (i.e. segues defined programmatically) and UIStoryboardSegue (segues defined in a storyboard), but the prepareForSegue:sender:userInfo: method will only be called for a ACStoryboardSegue.
 */
- (void)performSegueWithIdentifier:(NSString*)identifier sender:(id)sender userInfo:(NSDictionary*)userInfo;


//TODO
- (void)performSeguePath:(NSString*)path sender:(id)sender userInfo:(NSDictionary*)userInfo animated:(BOOL)animated;


/** Register a segue template.
 * @param segueTemplate A segue template to register with the view controller.
 * @discussion Registered templates can be called with the performSegueWithIdentifier:sender: method. Templates registered this way cannot be performed by a storyboard.
 */
- (void)registerSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate;

@end

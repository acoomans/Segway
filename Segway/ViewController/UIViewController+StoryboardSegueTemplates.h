//
//  UIViewController+StoryboardSegueTemplates.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACStoryboardSegueTemplate, ACStoryboardSegue;


/** UIViewController (StoryboardSegueTemplates) is a category to manage segues.
 *
 * This category let you programmatically register a ACStoryboardSegueTemplate with a UIViewController.
 */

@interface UIViewController (StoryboardSegueTemplates)

@property (nonatomic, copy) NSArray *ac_storyboardSegueTemplates;                           // storyboardSegueTemplates

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier;         // _segueTemplateWithIdentifier:

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_override_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender;

//TODO: - (void)performSegueWithIdentifier:(NSString*)identifier sender:(id)sender userInfo:(NSDictionary*)userInfo;

/** Register a segue template.
 * @param segueTemplate A segue template to register with the view controller.
 * @discussion Registered templates can be called with the performSegueWithIdentifier:sender: method. Templates registered this way cannot be performed by a storyboard.
 */
- (void)registerSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate;

@end

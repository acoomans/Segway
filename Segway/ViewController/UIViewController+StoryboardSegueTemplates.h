//
//  UIViewController+StoryboardSegueTemplates.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACStoryboardSegueTemplate, ACStoryboardSegue;


@interface UIViewController (StoryboardSegueTemplates)

@property (nonatomic, copy) NSArray *ac_storyboardSegueTemplates;                           // storyboardSegueTemplates

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier;         // _segueTemplateWithIdentifier:

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_override_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender;

//TODO: - (void)performSegueWithIdentifier:(NSString*)identifier sender:(id)sender userInfo:(NSDictionary*)userInfo;

- (void)registerSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate;

@end

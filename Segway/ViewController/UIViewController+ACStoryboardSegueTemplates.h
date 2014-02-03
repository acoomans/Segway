//
//  UIViewController+ACStoryboardSegueTemplates.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACStoryboardSegueTemplate, ACStoryboardSegue;


@interface UIViewController (ACStoryboardSegueTemplates)

@property (nonatomic, copy) NSArray *ac_storyboardSegueTemplates;

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier;

// Note: this method is swizzled with the original performSegueWithIdentifier:sender:
- (void)ac_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender;


//TODO: change "add" to "register"?
- (void)addSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate; // ac addition

- (void)registerTemplate:(Class)templateClass
   forSegueIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier; // ac addition

- (void)registerTemplate:(Class)templateClass
      forSegueIdentifier:(NSString*)identifier
destinationViewControllerclassName:(NSString*)className
             withNibName:(NSString*)nibName
                  bundle:(NSBundle*)bundle; // ac addition

@end

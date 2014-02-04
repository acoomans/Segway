//
//  UIViewController+ACStoryboardSegueTemplates.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIViewController+StoryboardSegueTemplates.h"
#import <objc/runtime.h>
#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"
#import "swizzling.h"


static char const * const UIViewControllerSegueTemplatesKey = "UIViewControllerSegueTemplates";

@implementation UIViewController (StoryboardSegueTemplates)

#pragma mark - Load

+ (void)load {
    MethodSwizzle(self, @selector(performSegueWithIdentifier:sender:), @selector(ac_override_performSegueWithIdentifier:sender:));
}

#pragma mark - Properties

- (NSArray*)ac_storyboardSegueTemplates {
    NSArray *segueTemplates = objc_getAssociatedObject(self, UIViewControllerSegueTemplatesKey);
    if (!segueTemplates) {
        segueTemplates = [NSArray array];
        objc_setAssociatedObject(self, UIViewControllerSegueTemplatesKey, segueTemplates, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return segueTemplates;
}

- (void)setAc_storyboardSegueTemplates:(NSArray*)segueTemplates {
    objc_setAssociatedObject(self, UIViewControllerSegueTemplatesKey, segueTemplates, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Registering templates

- (void)addSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate {
    segueTemplate.viewController = self;
    self.ac_storyboardSegueTemplates = [self.ac_storyboardSegueTemplates arrayByAddingObject:segueTemplate];
}

#pragma mark - Finding a template

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier {
	for (ACStoryboardSegueTemplate *segueTemplate in self.ac_storyboardSegueTemplates) {
		if ([segueTemplate.identifier isEqualToString:identifier]) {
			return segueTemplate;
		}
	}
    return nil;
}

#pragma mark - Performing a template

- (void)ac_override_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender {
	ACStoryboardSegueTemplate *storyboardSegue = [self ac_segueTemplateWithIdentifier:identifier];
	if (storyboardSegue) {
		[storyboardSegue _perform:sender];
	} else {
        [self ac_override_performSegueWithIdentifier:identifier sender:sender];
	}
}

- (void)performSegueWithIdentifier:(NSString*)identifier sender:(id)sender userInfo:(NSDictionary*)userInfo {
    
}

@end

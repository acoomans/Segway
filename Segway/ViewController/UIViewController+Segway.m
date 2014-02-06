//
//  UIViewController+Segway.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIViewController+Segway.h"
#import <objc/runtime.h>
#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"
#import "swizzling.h"


static char const * const UIViewControllerSegueTemplatesKey = "UIViewControllerSegueTemplates";

@implementation UIViewController (Segway)

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

- (void)registerSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate {
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
    [self performSegueWithIdentifier:identifier sender:sender userInfo:nil];
}

- (void)performSegueWithIdentifier:(NSString*)identifier sender:(id)sender userInfo:(NSDictionary*)userInfo {
	ACStoryboardSegueTemplate *segueTemplate = [self ac_segueTemplateWithIdentifier:identifier];
	if (segueTemplate) {
		[segueTemplate _perform:sender userInfo:userInfo];
	} else {
        [self ac_override_performSegueWithIdentifier:identifier sender:sender];
	}
}

- (void)performSeguePath:(NSString*)path sender:(id)sender userInfo:(NSDictionary*)userInfo animated:(BOOL)animated {
    NSArray *identifiers = [path componentsSeparatedByString:@"."];
    NSString *firstIdentifier = [identifiers firstObject];
    NSArray *nextIdentifiers = [identifiers subarrayWithRange:NSMakeRange(1, identifiers.count-1)];
    NSString *nextPath = [nextIdentifiers componentsJoinedByString:@"."];
    
    if (firstIdentifier.length) {
        ACStoryboardSegueTemplate *segueTemplate = [self ac_segueTemplateWithIdentifier:firstIdentifier];
        if (segueTemplate) {
            UIViewController *nextViewController = [segueTemplate _perform:sender userInfo:userInfo animated:animated];
            [nextViewController performSeguePath:nextPath sender:sender userInfo:userInfo animated:animated]; //TODO: force not animated?
            
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:[NSString stringWithFormat:@"Receiver (%@) has no segue with identifier '%@'", self, firstIdentifier]
                                         userInfo:nil];
        }
    }
}

@end

//
//  UIViewController+ACStoryboardSegueTemplates.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "UIViewController+ACStoryboardSegueTemplates.h"
#import <objc/runtime.h>
#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"


void __attribute__((weak)) MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL) {
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod = class_getInstanceMethod(c, overrideSEL);
    if (class_addMethod(c, origSEL, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(c, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

static char const * const UIViewControllerSegueTemplatesKey = "UIViewControllerSegueTemplates";

@implementation UIViewController (ACStoryboardSegueTemplates)

+ (void)load {
    MethodSwizzle(self, @selector(performSegueWithIdentifier:sender:), @selector(ac_performSegueWithIdentifier:sender:));
}

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

#pragma mark -

- (void)addSegueTemplate:(ACStoryboardSegueTemplate*)segueTemplate {
    segueTemplate.viewController = self;
    self.ac_storyboardSegueTemplates = [self.ac_storyboardSegueTemplates arrayByAddingObject:segueTemplate];
}

- (void)registerTemplate:(Class)templateClass
   forSegueIdentifier:(NSString*)identifier
destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    ACStoryboardSegueTemplate *segueTemplate = [[templateClass alloc] initWithIdentifier:identifier
                                                     destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    [self addSegueTemplate:segueTemplate];
}

- (ACStoryboardSegueTemplate*)ac_segueTemplateWithIdentifier:(NSString*)identifier {
	for (ACStoryboardSegueTemplate *segueTemplate in self.ac_storyboardSegueTemplates) {
		if ([segueTemplate.identifier isEqualToString:identifier]) {
			return segueTemplate;
		}
	}
    return nil;
}

- (void)ac_performSegueWithIdentifier:(NSString*)identifier sender:(id)sender {
	ACStoryboardSegueTemplate *storyboardSegue = [self ac_segueTemplateWithIdentifier:identifier];
	if (storyboardSegue) {
		[storyboardSegue _perform:sender];
	} else {
        [self ac_performSegueWithIdentifier:identifier sender:sender];
	}
}

@end

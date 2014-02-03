//
//  ACStoryboardPushSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardPushSegueTemplate.h"

static NSString * const ACStoryboardPushSegueTemplateDefaultSegueClassName = @"ACStoryboardPushSegue";


@implementation ACStoryboardPushSegueTemplate


//- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController // call super and use context (not implemented)

- (NSString*)defaultSegueClassName {
    return ACStoryboardPushSegueTemplateDefaultSegueClassName;
}

//- (void)encodeWithCoder:(id)arg1; // call super and use context (non implemented)
// - (id)initWithCoder:(id)arg1; // call super and use context (not implemented)

@end

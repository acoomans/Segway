//
//  ACStoryboardModalSegueTemplate.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardModalSegueTemplate.h"
#import "ACStoryboardModalSegue.h"

static NSString * const ACStoryboardModalSegueTemplateDefaultSegueClassName = @"ACStoryboardModalSegue";

@implementation ACStoryboardModalSegueTemplate

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier];
    if (self) {
        _animates = YES;
        _useDefaultModalPresentationStyle = YES;
        _useDefaultModalTransitionStyle = YES;
        _modalPresentationStyle = UIModalPresentationFullScreen;
        _modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}

#pragma mark - Perform segue

- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController {
    ACStoryboardModalSegue *modalSegue = (ACStoryboardModalSegue*)[super segueWithDestinationViewController:destinationViewController];
    modalSegue.useDefaultModalPresentationStyle = self.useDefaultModalPresentationStyle;
    modalSegue.useDefaultModalTransitionStyle = self.useDefaultModalTransitionStyle;
    modalSegue.modalPresentationStyle = self.modalPresentationStyle;
    modalSegue.modalTransitionStyle = self.modalTransitionStyle;
    modalSegue.animates = self.animates;
    return modalSegue;
}

- (NSString*)defaultSegueClassName {
    return ACStoryboardModalSegueTemplateDefaultSegueClassName;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder*)encoder {
    [super encodeWithCoder:encoder];
    
    if (!self.useDefaultModalPresentationStyle) {
        [encoder encodeInteger:self.modalPresentationStyle forKey:@"UIModalPresentationStyle"];
    }
    if (!self.useDefaultModalTransitionStyle) {
        [encoder encodeInteger:self.modalTransitionStyle forKey:@"UIModalTransitionStyle"];
    }
    if (!self.animates) {
        [encoder encodeBool:NO forKey:@"UIAnimates"];
    }
}

- (id)initWithCoder:(NSCoder*)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        
        if ([decoder containsValueForKey:@"UIModalPresentationStyle"]) {
            _modalPresentationStyle = [decoder decodeIntegerForKey:@"UIModalPresentationStyle"];
        } else {
            _useDefaultModalPresentationStyle = YES;
        }
        
        if ([decoder containsValueForKey:@"UIModalTransitionStyle"]) {
            _modalTransitionStyle = [decoder decodeIntegerForKey:@"UIModalTransitionStyle"];
        } else {
            _useDefaultModalTransitionStyle = YES;
        }
        
        if ([decoder containsValueForKey:@"UIAnimates"]) {
            _animates = [decoder decodeBoolForKey:@"UIAnimates"];
        } else {
            _animates = YES;
        }
    }
    return self;
}

@end

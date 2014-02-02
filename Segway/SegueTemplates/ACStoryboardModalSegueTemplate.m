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

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier {
    return [self initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier segueClassName:nil];
}

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier segueClassName:(NSString*)segueClassName {
    self = [super initWithIdentifier:identifier destinationViewControllerIdentifier:destinationViewControllerIdentifier segueClassName:segueClassName];
    if (self) {
        _useDefaultModalPresentationStyle = YES;
        _useDefaultModalTransitionStyle = YES;
        _modalPresentationStyle = UIModalPresentationFullScreen;
        _modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}


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

@end

//
//  ACStoryboardModalSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegueTemplate.h"

@interface ACStoryboardModalSegueTemplate : ACStoryboardSegueTemplate

@property (nonatomic) BOOL animates;
@property (nonatomic) UIModalTransitionStyle modalTransitionStyle;
@property (nonatomic) UIModalPresentationStyle modalPresentationStyle;
@property (nonatomic) BOOL useDefaultModalTransitionStyle;
@property (nonatomic) BOOL useDefaultModalPresentationStyle;

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier segueClassName:(NSString*)segueClassName; // ac addition

- (id)segueWithDestinationViewController:(id)arg1;
- (id)defaultSegueClassName;

@end

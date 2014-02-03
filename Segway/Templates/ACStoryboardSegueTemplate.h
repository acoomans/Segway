//
//  ACStoryboardSegueTemplate.h
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ACStoryboardSegue;


/** 
 * NSCoding protocol 
 */

@interface ACStoryboardSegueTemplate : NSObject

//@property (nonatomic, assign) BOOL performOnViewLoad; // not implemented

@property (nonatomic, weak) UIViewController *viewController;

@property (readonly, nonatomic, copy) NSString *identifier;

@property (readonly, nonatomic, copy) NSString *destinationViewControllerIdentifier;
@property (readonly, nonatomic, copy) NSString *destinationViewControllerClassName; // ac addition
@property (readonly, nonatomic, copy) NSString *destinationViewControllerNibName; // ac addition
@property (readonly, nonatomic, copy) NSBundle *destinationViewControllerBundle; // ac addition

- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerIdentifier:(NSString*)destinationViewControllerIdentifier;
- (instancetype)initWithIdentifier:(NSString*)identifier destinationViewControllerClassName:(NSString*)className withNibName:(NSString*)nibName bundle:(NSBundle*)bundle; // ac addition

- (void)perform:(id)sender;
- (void)_perform:(id)sender;

- (ACStoryboardSegue*)segueWithDestinationViewController:(UIViewController*)destinationViewController;

- (Class)effectiveSegueClass;
- (NSString*)defaultSegueClassName;

@end

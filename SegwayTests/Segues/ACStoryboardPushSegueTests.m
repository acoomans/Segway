//
//  ACStoryboardPushSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardPushSegueTemplate.h"
#import "ACStoryboardPushSegue.h"

@interface ACStoryboardPushSegueTests : XCTestCase
@end

@implementation ACStoryboardPushSegueTests

- (void)testRegisterAndPerform {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    UIViewController *viewControllerA = navigationController.topViewController;
    NSAssert([viewControllerA.title isEqualToString:@"A"] == YES, @"viewControllerA is not the root view controller");
    
    [viewControllerA registerTemplate:ACStoryboardPushSegueTemplate.class
                forSegueIdentifier:@"pushSegueIdentifier"
destinationViewControllerIdentifier:@"viewControllerB"];
    
    [viewControllerA performSegueWithIdentifier:@"pushSegueIdentifier" sender:self];
    
    XCTAssert([navigationController.topViewController.title isEqualToString:@"B"]);
    XCTAssert(navigationController.topViewController != viewControllerA);
    XCTAssert([navigationController.viewControllers count] == 2);
}

@end

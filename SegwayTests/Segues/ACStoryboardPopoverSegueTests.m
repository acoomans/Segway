//
//  ACStoryboardPopoverSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "UIViewController+Popover.h"
#import "ACStoryboardPopoverSegueTemplate.h"
#import "ACStoryboardPopoverSegue.h"


@interface ACStoryboardPopoverSegueTests : XCTestCase
@end

@implementation ACStoryboardPopoverSegueTests

// NOT WORKING (cannot make popovers work in unit tests)


- (void)testRegisterAndPerformFromView {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];

    UIViewController *viewControllerA = navigationController.topViewController;
    NSAssert(viewControllerA != nil, @"No top view controller present");
    NSAssert(viewControllerA.navigationController.navigationBar != nil, @"view has no navigation bar");
    
    [viewControllerA addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                               destinationViewControllerIdentifier:@"viewControllerB"
                                                                                        anchorView:viewControllerA.navigationController.navigationBar
                                                                          permittedArrowDirections:UIPopoverArrowDirectionAny]];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    XCTAssertNotNil(viewControllerA.popoverViewController);
    XCTAssert([viewControllerA.popoverViewController.contentViewController.title isEqualToString:@"B"]);
}


- (void)testRegisterAndPerformFromBarButtonItem {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    
    UIViewController *viewControllerA = navigationController.topViewController;
    NSAssert(viewControllerA != nil, @"No top view controller present");
    NSAssert(viewControllerA.navigationController.navigationBar != nil, @"view has no navigation bar");
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                   target:nil
                                                                                   action:nil];
    viewControllerA.navigationItem.rightBarButtonItem = barButtonItem;
    NSAssert(viewControllerA.navigationItem.rightBarButtonItem != nil, @"viewControllerA has no right bar button item");
    
    [viewControllerA addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                               destinationViewControllerIdentifier:@"viewControllerB"
                                                                               anchorBarButtonItem:barButtonItem
                                                                          permittedArrowDirections:UIPopoverArrowDirectionAny]];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    XCTAssertNotNil(viewControllerA.popoverViewController);
    XCTAssert([viewControllerA.popoverViewController.contentViewController.title isEqualToString:@"B"]);
}

@end

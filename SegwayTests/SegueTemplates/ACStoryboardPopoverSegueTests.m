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
    
    dispatch_semaphore_t mutex = dispatch_semaphore_create(0);
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    UIViewController *viewControllerA = navigationController.topViewController;
    NSAssert(viewControllerA != nil, @"No top view controller present");
    
    viewControllerA.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                      target:nil
                                                                                                      action:nil];
    
    window.rootViewController = navigationController;
    [window addSubview:viewControllerA.view];
    NSAssert(viewControllerA.view.window != nil, @"view has no window");
    [window makeKeyAndVisible];
    
    
    //NSAssert(viewControllerA.navigationController.navigationBar != nil, @"view has no navigation bar");
    UIBarButtonItem *barButtonItem = viewControllerA.navigationItem.rightBarButtonItem;
    NSAssert(barButtonItem != nil, @"viewControllerA has no right bar button item");
    
    [viewControllerA addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                               destinationViewControllerIdentifier:@"viewControllerB"
                                                                               anchorBarButtonItem:barButtonItem
                                                                          permittedArrowDirections:UIPopoverArrowDirectionAny]];
    
    /*
     [viewControllerA addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
     destinationViewControllerIdentifier:@"viewControllerB"
     anchorBarButtonItem:barButtonItem
     permittedArrowDirections:UIPopoverArrowDirectionAny]];
     */
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    
    
    dispatch_semaphore_wait(mutex, dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC));
    
    XCTAssertNotNil(viewControllerA.presentedViewController);
    XCTAssert([viewControllerA.presentedViewController.title isEqualToString:@"B"]);
    
    
    //viewControllerA.view = nil;
    //window.rootViewController= nil;
}

@end

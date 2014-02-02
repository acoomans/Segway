//
//  ACStoryboardPopoverSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardPopoverSegueTemplate.h"
#import "ACStoryboardPopoverSegue.h"


@interface ACStoryboardPopoverSegueTests : XCTestCase
@end

@implementation ACStoryboardPopoverSegueTests

// NOT WORKING (cannot make popovers work in unit tests)

/*
- (void)testRegisterAndPerform {
    
    // we need a window or presenting modally won't work
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 1024, 1024)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    window.rootViewController = viewControllerA;
    [window makeKeyAndVisible];
    
    UIBarButtonItem *barButtonItem = viewControllerA.navigationItem.rightBarButtonItem;
    NSAssert(barButtonItem != nil, @"viewControllerA has no right bar button item");
    
    
    [viewControllerA addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                    destinationViewControllerIdentifier:@"viewControllerB"
                                                                    anchorBarButtonItem:barButtonItem
                                                               permittedArrowDirections:UIPopoverArrowDirectionAny]];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    XCTAssertNotNil(viewControllerA.presentedViewController);
    XCTAssert([viewControllerA.presentedViewController.title isEqualToString:@"B"]);
}
*/

@end

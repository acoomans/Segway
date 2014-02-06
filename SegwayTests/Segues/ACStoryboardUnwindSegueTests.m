//
//  ACStoryboardUnwindSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>

#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardPushSegueTemplate.h"
#import "ACStoryboardModalSegueTemplate.h"

#import "ACStoryboardUnwindSegueTemplate.h"


static BOOL unwindResult;

@interface ACUnwindableViewController : UIViewController
@end

@implementation ACUnwindableViewController
- (void)unwindToMainViewController:(UIStoryboardSegue*)sender {
    unwindResult = YES;
}
@end


@interface ACStoryboardUnwindSegueTests : XCTestCase
@end

@implementation ACStoryboardUnwindSegueTests

- (void)testRegisterAndPerform {
    
    unwindResult = NO;
    
    UIWindow *window = [[UIWindow alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Navigation" bundle:[NSBundle bundleForClass:self.class]];
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    
    UIViewController *viewControllerA = navigationController.topViewController;
    NSAssert([viewControllerA.title isEqualToString:@"A"] == YES, @"viewControllerA is not the root view controller");
    
    [viewControllerA addSegueTemplate:[[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"pushSegueIdentifier"
                                                            destinationViewControllerIdentifier:@"viewControllerB"]];
    
    [viewControllerA performSegueWithIdentifier:@"pushSegueIdentifier" sender:self];
    
    XCTAssert([navigationController.topViewController.title isEqualToString:@"B"]);
    XCTAssert(navigationController.topViewController != viewControllerA);
    XCTAssert([navigationController.viewControllers count] == 2);
    
    UIViewController *viewControllerB = navigationController.topViewController;
    
    [viewControllerB addSegueTemplate:[[ACStoryboardUnwindSegueTemplate alloc] initWithIdentifier:@"unwindSegueIdentifier"
                                                                                           action:@"unwindToMainViewController:"]];
    
    
    //dispatch_semaphore_t mutex = dispatch_semaphore_create(0);
    //dispatch_semaphore_wait(mutex, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)));
    
    [viewControllerB performSegueWithIdentifier:@"unwindSegueIdentifier" sender:self];
    
    //dispatch_semaphore_wait(mutex, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)));
    
    XCTAssert([navigationController.topViewController.title isEqualToString:@"A"]);
    XCTAssert(navigationController.topViewController == viewControllerA);
    XCTAssert([navigationController.viewControllers count] == 1);
    
    XCTAssertTrue(unwindResult);
}






- (void)testRegisterAndPerformUnwindModal {
    
    unwindResult = NO;
    
    UIWindow *window = [[UIWindow alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateInitialViewController];
    
    window.rootViewController = viewControllerA;
    [window makeKeyAndVisible];
    
    [viewControllerA addSegueTemplate:[[ACStoryboardModalSegueTemplate alloc] initWithIdentifier:@"modalSegueIdentifier"
                                                             destinationViewControllerIdentifier:@"viewControllerB"]];
    
    [viewControllerA performSegueWithIdentifier:@"modalSegueIdentifier" sender:self];
    
    XCTAssertNotNil(viewControllerA.presentedViewController);
    XCTAssert([viewControllerA.presentedViewController.title isEqualToString:@"B"]);
    
    UIViewController *viewControllerB = viewControllerA.presentedViewController;
    
    [viewControllerB addSegueTemplate:[[ACStoryboardUnwindSegueTemplate alloc] initWithIdentifier:@"unwindSegueIdentifier"
                                                                                           action:@"unwindToMainViewController:"]];
    
    [viewControllerB performSegueWithIdentifier:@"unwindSegueIdentifier" sender:self];
    
    
    XCTAssertNil(viewControllerA.presentedViewController);
    
    //XCTAssertTrue(unwindResult);
}

@end

//
//  ACStoryboardModalSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardModalSegueTemplate.h"
#import "ACStoryboardModalSegue.h"

@interface ACStoryboardModalSegueTests : XCTestCase
@end

@implementation ACStoryboardModalSegueTests

- (void)testRegisterAndPerform {
    
    //UIWindow *window = [[UIWindow alloc] init];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    //window.rootViewController = viewControllerA;
    //[window makeKeyAndVisible];
    
    [viewControllerA registerClass:ACStoryboardModalSegue.class
                forSegueIdentifier:@"segueIdentifier"
destinationViewControllerIdentifier:@"viewControllerB"];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    XCTAssertNotNil(viewControllerA.presentedViewController);
    XCTAssert([viewControllerA.presentedViewController.title isEqualToString:@"B"]);
}

@end

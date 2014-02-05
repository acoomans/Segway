//
//  ACStoryboardSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+Segway.h"
#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"


static NSDictionary *testResult;

@interface ACStoryboardTestSegue : ACStoryboardSegue
@end
@implementation ACStoryboardTestSegue
- (void)perform {
    __weak __block id weakSelf = self;
    testResult = @{@"segue": weakSelf};
}
@end

static NSDictionary *performUserInfo;

@interface ACViewController : UIViewController
@end
@implementation ACViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender userInfo:(NSDictionary*)userInfo {
    performUserInfo = userInfo;
}
@end



@interface ACStoryboardSegueTests : XCTestCase
@end

@implementation ACStoryboardSegueTests

- (void)setUp {
    [super setUp];
    testResult = nil;
    performUserInfo = nil;
}

- (void)testSegueWithDestinationViewController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    UIViewController *viewControllerB = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerB"];
    
    ACStoryboardSegueTemplate *segueTemplate = [[ACStoryboardSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                                         destinationViewControllerIdentifier:@"viewControllerB"];
    segueTemplate.segueClassName = NSStringFromClass(ACStoryboardTestSegue.class);
    [viewControllerA registerSegueTemplate:segueTemplate];
    
    ACStoryboardSegue *segue = [segueTemplate segueWithDestinationViewController:viewControllerB];
    
    XCTAssert([segue.identifier isEqualToString:@"segueIdentifier"]);
    XCTAssert([segue.sourceViewController.title isEqualToString:@"A"]);
    XCTAssert([segue.destinationViewController.title isEqualToString:@"B"]);
}

- (void)testRegisterAndPerform {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    ACStoryboardSegueTemplate *segueTemplate = [[ACStoryboardSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                                 destinationViewControllerIdentifier:@"viewControllerB"];
    segueTemplate.segueClassName = NSStringFromClass(ACStoryboardTestSegue.class);
    [viewControllerA registerSegueTemplate:segueTemplate];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    ACStoryboardSegue *segue = testResult[@"segue"];
    XCTAssert([segue isKindOfClass:ACStoryboardTestSegue.class]);
    XCTAssert([segue.identifier isEqualToString:@"segueIdentifier"]);
    XCTAssert([segue.sourceViewController.title isEqualToString:@"A"]);
    XCTAssert([segue.destinationViewController.title isEqualToString:@"B"]);
}


- (void)testCompatibilityWithSegueFromStoryboardFile {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    [viewControllerA performSegueWithIdentifier:@"segueInStoryboard" sender:self];
    
    ACStoryboardSegue *segue = testResult[@"segue"];
    XCTAssert([segue isKindOfClass:ACStoryboardTestSegue.class]);
    XCTAssert([segue.identifier isEqualToString:@"segueInStoryboard"]);
    XCTAssert([segue.sourceViewController.title isEqualToString:@"A"]);
    XCTAssert([segue.destinationViewController.title isEqualToString:@"B"]);
}

- (void)testPerformUserInfo {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    ACStoryboardSegueTemplate *segueTemplate = [[ACStoryboardSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                                 destinationViewControllerIdentifier:@"viewControllerB"];
    segueTemplate.segueClassName = NSStringFromClass(ACStoryboardTestSegue.class);
    [viewControllerA registerSegueTemplate:segueTemplate];
    
    NSDictionary *userInfo = @{@"key": @"value"};
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self userInfo:userInfo];
    
    XCTAssert(performUserInfo == userInfo);
}

@end

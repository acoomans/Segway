//
//  ACStoryboardSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardSegueTemplate.h"
#import "ACStoryboardSegue.h"

static NSDictionary *testResult;

@interface ACStoryboardTestSegueTemplate : ACStoryboardSegueTemplate
@property (nonatomic, copy) NSString *defaultSegueClassName;
@end
@implementation ACStoryboardTestSegueTemplate
- (NSString*)defaultSegueClassName {
    return @"ACStoryboardTestSegue";
}
@end

@interface ACStoryboardTestSegue : ACStoryboardSegue
@end
@implementation ACStoryboardTestSegue
- (void)perform {
    __weak __block id weakSelf = self;
    testResult = @{@"segue": weakSelf};
}
@end


@interface ACStoryboardSegueTests : XCTestCase
@end

@implementation ACStoryboardSegueTests

- (void)setUp {
    [super setUp];
    testResult = nil;
}

- (void)testSegueWithDestinationViewController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    UIViewController *viewControllerB = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerB"];
    
    ACStoryboardTestSegueTemplate *segueTemplate = [[ACStoryboardTestSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                                         destinationViewControllerIdentifier:@"viewControllerB"];
    [viewControllerA addSegueTemplate:segueTemplate];
    
    ACStoryboardSegue *segue = [segueTemplate segueWithDestinationViewController:viewControllerB];
    
    XCTAssert([segue.identifier isEqualToString:@"segueIdentifier"]);
    XCTAssert([segue.sourceViewController.title isEqualToString:@"A"]);
    XCTAssert([segue.destinationViewController.title isEqualToString:@"B"]);
}

- (void)testAddAndPerform {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    ACStoryboardTestSegueTemplate *segueTemplate = [[ACStoryboardTestSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                                         destinationViewControllerIdentifier:@"viewControllerB"];
    [viewControllerA addSegueTemplate:segueTemplate];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    ACStoryboardSegue *segue = testResult[@"segue"];
    XCTAssert([segue isKindOfClass:ACStoryboardTestSegue.class]);
    XCTAssert([segue.identifier isEqualToString:@"segueIdentifier"]);
    XCTAssert([segue.sourceViewController.title isEqualToString:@"A"]);
    XCTAssert([segue.destinationViewController.title isEqualToString:@"B"]);
}

- (void)testRegisterAndPerform {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Default" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"viewControllerA"];
    
    [viewControllerA registerTemplate:ACStoryboardTestSegueTemplate.class forSegueIdentifier:@"segueIdentifier" destinationViewControllerIdentifier:@"viewControllerB"];
    
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

@end

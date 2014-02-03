//
//  ACStoryboardEmbedSegueTests.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIViewController+ACStoryboardSegueTemplates.h"
#import "ACStoryboardEmbedSegueTemplate.h"
#import "ACStoryboardEmbedSegue.h"

@interface ACViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIView *containerView;
@end

@implementation ACViewController
@end


@interface ACStoryboardEmbedSegueTests : XCTestCase
@end

@implementation ACStoryboardEmbedSegueTests

- (void)testRegisterAndPerform {
    
    UIWindow *window = [[UIWindow alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Container" bundle:[NSBundle bundleForClass:self.class]];
    ACViewController *viewControllerA = [storyboard instantiateInitialViewController];
    
    window.rootViewController = viewControllerA;
    [window makeKeyAndVisible];
    
    [viewControllerA addSegueTemplate:[[ACStoryboardEmbedSegueTemplate alloc] initWithIdentifier:@"segueIdentifier"
                                                             destinationViewControllerIdentifier:@"viewControllerB"
                                                                                   containerView:viewControllerA.containerView]];
    
    [viewControllerA performSegueWithIdentifier:@"segueIdentifier" sender:self];
    
    UIViewController *viewControllerB = ((UIViewController*)[viewControllerA.childViewControllers firstObject]);
    
    XCTAssert([viewControllerB.title isEqualToString:@"B"]);
    XCTAssert([viewControllerA.containerView.subviews containsObject:viewControllerB.view]);
}

@end

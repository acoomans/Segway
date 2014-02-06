//
//  ACViewController.m
//  Test2
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACViewController.h"
#import "Segway.h"

@interface ACViewController ()
@end

#pragma mark - View management

@implementation ACViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *performButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [performButton setTitle:@"Perform" forState:UIControlStateNormal];
    [performButton addTarget:self action:@selector(perform:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:performButton];
    performButton.frame = CGRectMake(60, 100, 200, 30);
    
    UIButton *unwindButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [unwindButton setTitle:@"Unwind" forState:UIControlStateNormal];
    [unwindButton addTarget:self action:@selector(unwind:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unwindButton];
    unwindButton.frame = CGRectMake(60, 150, 200, 30);
    
    
    [self registerSegueTemplate:[[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"push"
                                                        destinationViewControllerClassName:NSStringFromClass(ACViewController.class)
                                                                               withNibName:nil
                                                                                    bundle:nil]];

    [self registerSegueTemplate:[[ACStoryboardUnwindSegueTemplate alloc] initWithIdentifier:@"unwind"
                                                                                     action:@"unwindToViewController:"]];
}

#pragma mark - Actions

- (IBAction)perform:(id)sender {
    [self performSegueWithIdentifier:@"push" sender:nil userInfo:@{@"message": @"Push!"}];
}

- (IBAction)unwind:(id)sender {
    [self performSegueWithIdentifier:@"unwind" sender:nil userInfo:@{@"message": @"Unwind!"}];
}

#pragma mark - Segues

- (void)unwindToViewController:(UIStoryboardSegue*)sender {
    NSLog(@"unwindToViewController:%@", sender);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue:%@ sender:%@", segue, sender);
    NSLog(@"userInfo:%@", segue.userInfo);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender userInfo:(NSDictionary*)userInfo {
    NSLog(@"prepareForSegue:%@ sender:%@ userInfo:%@", segue, sender, userInfo);
}


@end

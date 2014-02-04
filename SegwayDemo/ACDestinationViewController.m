//
//  ACDestinationViewController.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACDestinationViewController.h"
#import "Segway.h"

@implementation ACDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Unwind segue is defined programmatically here
    [self registerSegueTemplate:[[ACStoryboardUnwindSegueTemplate alloc] initWithIdentifier:@"unwind" action:@"unwindToMainViewController:"]];
    
}

#pragma mark - actions

- (IBAction)unwindAction:(id)sender {
    [self performSegueWithIdentifier:@"unwind" sender:self];
}

@end
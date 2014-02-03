//
//  ACContainerSourceViewController.m
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACContainerSourceViewController.h"
#import "Segway.h"

@interface ACContainerSourceViewController ()
@end

@implementation ACContainerSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Embed segue is defined programmatically here
    [self addSegueTemplate:[[ACStoryboardEmbedSegueTemplate alloc] initWithIdentifier:@"embed"
                                                  destinationViewControllerIdentifier:@"destinationViewController"
                                                                        containerView:self.containerView]];
}

#pragma mark - actions

- (IBAction)perform:(id)sender {
    [self performSegueWithIdentifier:@"embed" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue:%@ sender:%@", segue, sender);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //NOTE: is only called by storyboard actions, but not called by performSegueWithIdentifier:sender: (following Apple's implementation)
    return YES;
}



@end

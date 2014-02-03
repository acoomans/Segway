//
//  ACMainViewController.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACMainViewController.h"
#import "Segway.h"


@implementation ACMainViewController

#pragma mark - View management

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Segues are defined programmatically here
    
    [self registerTemplate:ACStoryboardPushSegueTemplate.class forSegueIdentifier:@"push" destinationViewControllerIdentifier:@"destinationViewController"];
    
    [self registerTemplate:ACStoryboardModalSegueTemplate.class forSegueIdentifier:@"modal" destinationViewControllerIdentifier:@"destinationViewController"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"popover" destinationViewControllerIdentifier:@"destinationViewController" anchorView:self.navigationController.navigationBar permittedArrowDirections:UIPopoverArrowDirectionAny]];
    }
    
    // we'll demo the embed segue from ACContainerSourceViewController, just push it for now
    [self registerTemplate:ACStoryboardPushSegueTemplate.class forSegueIdentifier:@"embed" destinationViewControllerIdentifier:@"containerSourceViewController"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ac_storyboardSegueTemplates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ACStoryboardSegueTemplate *segueTemplate = self.ac_storyboardSegueTemplates[indexPath.row];
    
    cell.textLabel.text = [[NSString stringWithFormat:@"%@ segue", segueTemplate.identifier] capitalizedString];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ACStoryboardSegueTemplate *segueTemplate = self.ac_storyboardSegueTemplates[indexPath.row];
    
    [self performSegueWithIdentifier:segueTemplate.identifier sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue:%@ sender:%@", segue, sender);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //NOTE: is only called by storyboard actions, but not called by performSegueWithIdentifier:sender: (following Apple's implementation)
    return YES;
}

- (IBAction)unwindToMainViewController:(UIStoryboardSegue*)sender {
    NSLog(@"unwindToMainViewController:%@", sender);
}

@end

//
//  ACMainViewController.m
//  Segway
//
//  Created by Arnaud Coomans on 01/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACMainViewController.h"
#import "Segway.h"

NS_ENUM(NSInteger, ACMainViewControllerSection) {
    ACMainViewControllerSectionSegway,
    ACMainViewControllerSectionStoryboard,
};

NS_ENUM(NSInteger, ACMainViewControllerSectionStoryboardRow) {
    ACMainViewControllerSectionStoryboardRowPush,
    ACMainViewControllerSectionStoryboardRowModal,
//    ACMainViewControllerSectionStoryboardRow,
};


@implementation ACMainViewController

#pragma mark - View management

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Segues are defined programmatically here
    
    [self registerSegueTemplate:[[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"push"
                                                 destinationViewControllerIdentifier:@"destinationViewController"]];
    
    [self registerSegueTemplate:[[ACStoryboardModalSegueTemplate alloc] initWithIdentifier:@"modal"
                                                  destinationViewControllerIdentifier:@"destinationViewController"]];
    
    // set some parameters to the template
    ACStoryboardModalSegueTemplate *template = [[ACStoryboardModalSegueTemplate alloc] initWithIdentifier:@"modal (flip transition)"
                                                                      destinationViewControllerIdentifier:@"destinationViewController"];
    template.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    template.useDefaultModalTransitionStyle = NO;
    [self registerSegueTemplate:template];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self registerSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"popover" destinationViewControllerIdentifier:@"destinationViewController" anchorView:self.navigationController.navigationBar permittedArrowDirections:UIPopoverArrowDirectionAny]];
    }
    
    // we'll demo the embed segue from ACContainerSourceViewController, just push it for now
    [self registerSegueTemplate:[[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"embed"
                                                 destinationViewControllerIdentifier:@"containerSourceViewController"]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case ACMainViewControllerSectionSegway: {
            return [self.ac_storyboardSegueTemplates count];
        }
            
        case ACMainViewControllerSectionStoryboard: {
            return 2;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    switch (indexPath.section) {
            
        case ACMainViewControllerSectionSegway: {
            static NSString *cellIdentifier = @"Cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            ACStoryboardSegueTemplate *segueTemplate = self.ac_storyboardSegueTemplates[indexPath.row];
            cell.textLabel.text = [[NSString stringWithFormat:@"%@ segue", segueTemplate.identifier] capitalizedString];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
            
        case ACMainViewControllerSectionStoryboard: {
            switch (indexPath.row) {
                case ACMainViewControllerSectionStoryboardRowPush:
                    return [tableView dequeueReusableCellWithIdentifier:@"storyboardPushCell"];
                case ACMainViewControllerSectionStoryboardRowModal:
                    return [tableView dequeueReusableCellWithIdentifier:@"storyboardModalCell"];
                default:
                    break;
            }
            break;
        }
    }
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case ACMainViewControllerSectionSegway: {
            return @"Segway";
        }
        case ACMainViewControllerSectionStoryboard: {
            return @"Storyboard (UIKit)";
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case ACMainViewControllerSectionSegway: {
            ACStoryboardSegueTemplate *segueTemplate = self.ac_storyboardSegueTemplates[indexPath.row];
            [self performSegueWithIdentifier:segueTemplate.identifier sender:self userInfo:@{@"indexPath": indexPath}];
        }
        case ACMainViewControllerSectionStoryboard: {
            return;
        }
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender userInfo:(NSDictionary *)userInfo {
    NSLog(@"prepareForSegue:%@ sender:%@ userInfo:%@", segue, sender, userInfo);
}

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

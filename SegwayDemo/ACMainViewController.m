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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInitialization];
}

- (void)commonInitialization {
    
    // Segues are defined programmatically here
    
    [self registerTemplate:ACStoryboardPushSegueTemplate.class forSegueIdentifier:@"push" destinationViewControllerIdentifier:@"destinationViewController"];
    
    [self registerTemplate:ACStoryboardModalSegueTemplate.class forSegueIdentifier:@"modal" destinationViewControllerIdentifier:@"destinationViewController"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self addSegueTemplate:[[ACStoryboardPopoverSegueTemplate alloc] initWithIdentifier:@"popover" destinationViewControllerIdentifier:@"destinationViewController" anchorView:self.navigationController.navigationBar permittedArrowDirections:UIPopoverArrowDirectionAny]];
    }
}

#pragma mark - View management

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nothing special here, feel free to play around
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
    
    // nothing special here, feel free to play around
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    //NOTE: is only called by storyboard actions, but not called by performSegueWithIdentifier:sender: (following Apple's implementation)
    
    return YES;
}

- (IBAction)unwindToMainViewController:(UIStoryboardSegue*)sender {
    // come back here
}

@end

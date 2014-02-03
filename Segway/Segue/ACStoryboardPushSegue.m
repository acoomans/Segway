//
//  ACStoryboardPushSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardPushSegue.h"

@implementation ACStoryboardPushSegue

#pragma mark - Perform segue

- (void)perform {
    
    if (!self.sourceViewController.navigationController) {
        
        NSString *msg = nil;
        
        if (self.identifier) {
            msg = [NSString stringWithFormat:@"Could not find a navigation controller for segue '%@'. %@", self.identifier, @"Push segues can only be used when the source controller is managed by an instance of UINavigationController."];
        } else {
            msg = @"Push segues can only be used when the source controller is managed by an instance of UINavigationController.";
        }
        
        @throw [NSException exceptionWithName:NSGenericException reason:msg userInfo:nil];
        
    }
    [self.sourceViewController.navigationController pushViewController:self.destinationViewController animated:YES];
}

@end

//
//  ACAppDelegate.m
//  Test2
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACViewController.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ACViewController alloc] initWithNibName:nil bundle:nil]];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

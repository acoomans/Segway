//
//  ACStoryboardSegue.m
//  Segway
//
//  Created by Arnaud Coomans on 31/01/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "ACStoryboardSegue.h"

@implementation ACStoryboardSegue

#pragma mark - Initialzation

+ (instancetype)segueWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination performHandler:(void (^)(void))performHandler {
    ACStoryboardSegue *storyboardSegue = [[self alloc] initWithIdentifier:identifier source:source destination:destination];
    storyboardSegue.performHandler = performHandler;
    return storyboardSegue;
}

- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _sourceViewController = source;
        _destinationViewController = destination;
    }
    return self;
}

#pragma mark - Perform segue

- (void)perform {
    if (self.performHandler) {
        self.performHandler();
    } else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Subclasses of UIStoryboardSegue must override -perform." userInfo:nil];
    }
}

#pragma mark - description

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ (%@) %@ -> %@", [super description], self.identifier, self.sourceViewController, self.destinationViewController];
}

@end

//
//  MODTransitioningBaseDelegate.m
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitioningBase.h"
#import "MODDefaults.h"

@interface MODTransitioningBase ()

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation MODTransitioningBase

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.transitionDuration = MODDefaulTransitionDuration;
        self.transitionType = MODTransitionTypeFullScreen;
    }
    
    return self;
}

#pragma mark - Accessors

- (void)setTransitionDuration:(CGFloat)transitionDuration {
    
    if (transitionDuration == MODDefaulTransitionDuration) {
        _transitionDuration = [self defaultTransitionDuration];
    }
    else {
        _transitionDuration = transitionDuration;
    }
}

#pragma mark - Private methdos

- (CGFloat)defaultTransitionDuration {
    
    return 0.5;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [NSException raise:@"Illegal execution exception" format:@"%@", @"This method should not be executed in this class. Override it in its subclasses."];
}

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return self.transitionDuration;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.isPresenting = NO;
    return self;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    self.isNavigationAnimation = YES;
    
    if (operation == UINavigationControllerOperationPush) {
        self.isPresenting = YES;
    }
    else {
        self.isPresenting = NO;
    }
    return self;
}

@end

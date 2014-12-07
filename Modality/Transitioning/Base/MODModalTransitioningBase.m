//
//  MODModalTransitioningBase.m
//  Modality
//
//  Created by Kevin on 20/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODModalTransitioningBase.h"
#import "MODModalHelper.h"

@interface MODModalTransitioningBase ()

@end

@implementation MODModalTransitioningBase

#pragma mark - Factory methods

+ (instancetype)transitionAnimatorWithDirection:(MODDirection)direction
                          destinationViewLength:(CGFloat)destinationViewLength {

    MODModalTransitioningBase *modalTransitioningBase = [[self class] new];
    modalTransitioningBase.direction = direction;
    modalTransitioningBase.destinationViewLength = destinationViewLength;
    
    return modalTransitioningBase;
}

#pragma mark - Accessors

- (MODTransitionType)transitionType {
    
    return MODTransitionTypeModal;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *container = [transitionContext containerView];
    
    if (self.isPresenting) {
        
        UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [MODModalHelper addModalBackgroundAnimationToView:container withDuration:self.transitionDuration alpha:0.3f destinationViewController:destinationViewController];
    }
    else {
        
        [MODModalHelper removeModalBackgroundAnimationFromView:container withDuration:self.transitionDuration];
    }
}

@end

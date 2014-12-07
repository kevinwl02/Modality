//
//  MODTransitionAnimatorFade.m
//  Modality
//
//  Created by Kevin on 28/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitionAnimatorFade.h"
#import "MODDefaults.h"
#import "MODViewHelper.h"

@implementation MODTransitionAnimatorFade

+ (instancetype)transitionAnimatior {
    
    return [self new];
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
 
    UIView *container = [transitionContext containerView];
    
    if (self.isPresenting) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        if (self.isNavigationAnimation) {
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            [container addSubview:[MODViewHelper snapshotCopyOfView:fromView]];
        }

        [container addSubview:toView];
        
        toView.alpha = 0;
        [UIView animateWithDuration:self.transitionDuration animations:^{
            
            toView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                [transitionContext completeTransition:YES];
            }
        }];
    }
    else {
        
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        if (self.isNavigationAnimation) {
            UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
            [container addSubview:toView];
        }
        [container addSubview:fromView];
        
        [UIView animateWithDuration:self.transitionDuration animations:^{
            
            fromView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                [transitionContext completeTransition:YES];
            }
        }];
    }
}

- (MODTransitionType)transitionType {
    return MODTransitionTypeModal;
}

@end

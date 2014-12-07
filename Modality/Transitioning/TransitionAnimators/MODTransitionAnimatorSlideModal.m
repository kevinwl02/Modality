//
//  MODTransitionAnimatorSlideModal.m
//  Modality
//
//  Created by Kevin on 11/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitionAnimatorSlideModal.h"
#import "MODTransformFactory.h"
#import "MODModalHelper.h"
#import "MODPropertiesHelper.h"
#import "MODViewHelper.h"
#import "MODDefaults.h"

@interface MODTransitionAnimatorSlideModal ()

@property (nonatomic, strong) NSLayoutConstraint *animationConstraint;
@property (nonatomic, assign) CGFloat initialAnimationConstant;

@end

@implementation MODTransitionAnimatorSlideModal

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [super animateTransition:transitionContext];
    
    UIView *container = [transitionContext containerView];
    
    if (self.isPresenting) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [toView layoutIfNeeded];
        [container addSubview:toView];
        
        self.animationConstraint = [MODModalHelper setupFrameForView:toView inContainerView:container withLength:self.destinationViewLength andDirection:self.direction offset:1];
        self.initialAnimationConstant = self.animationConstraint.constant;
        [container layoutIfNeeded];
        
        UIView *snapshotView = [MODViewHelper onePixelLineStretchedSnapshotOfView:toView withDirection:self.direction];
        [container insertSubview:snapshotView belowSubview:toView];
         NSLayoutConstraint *snapshotAnimationConstraint = [MODModalHelper setupFrameForView:snapshotView inContainerView:container withLength:self.destinationViewLength andDirection:self.direction offset:2];
        [container layoutIfNeeded];
        
        CGFloat constraintDifference = snapshotAnimationConstraint.constant - self.animationConstraint.constant;
        self.animationConstraint.constant = 0;
        snapshotAnimationConstraint.constant = constraintDifference;
        
        [UIView animateWithDuration:self.transitionDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:1 options:0 animations:^{
            
            [container layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:YES];
                [snapshotView removeFromSuperview];
            }
        }];
    }
    else {
        
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [container addSubview:fromView];

        self.animationConstraint.constant = self.initialAnimationConstant;
        
        [UIView animateWithDuration:self.transitionDuration animations:^{
            [container layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:YES];
                [fromView removeFromSuperview];
            }
        }];
    }
}

@end

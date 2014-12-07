//
//  MODTransitionAnimatorFlipModal.m
//  Modality
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitionAnimatorFlipModal.h"
#import "MODModalHelper.h"

@implementation MODTransitionAnimatorFlipModal

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    [super animateTransition:transitionContext];
    
    UIView *container = [transitionContext containerView];
    
    BOOL horizontal = self.direction == MODDirectionLeft || self.direction == MODDirectionRight;
    
    if (self.isPresenting) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [toView layoutIfNeeded];
        [container addSubview:toView];
        
        [MODModalHelper setupFrameForView:toView inContainerView:container withLength:self.destinationViewLength andDirection:self.direction offset:0];
        
        [self flipView:toView horizontal:horizontal];
        toView.alpha = 0;
        
        [UIView animateWithDuration:self.transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [self flipToIdentity:toView];
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [container addSubview:fromView];
        
        [UIView animateWithDuration:self.transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.alpha = 0;
            [self flipView:fromView horizontal:horizontal];
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)flipView:(UIView *)view horizontal:(BOOL)horizontal {
    
    CATransform3D transformLayer = CATransform3DIdentity;
    transformLayer.m34 = -0.0001;
    transformLayer = CATransform3DTranslate(transformLayer, 0, 0, 5000);
    transformLayer = CATransform3DRotate(transformLayer, 150 / 180.0 * M_PI, 1 * !horizontal, 1 * horizontal, 0);
    
    view.layer.transform = transformLayer;
}

- (void)flipToIdentity:(UIView *)view {
    
    CATransform3D transformLayer = CATransform3DIdentity;
    transformLayer = CATransform3DTranslate(transformLayer, 0, 0, 5000);
    view.layer.transform = transformLayer;
}

- (CGFloat)defaultTransitionDuration {
    
    return 0.35;
}

@end

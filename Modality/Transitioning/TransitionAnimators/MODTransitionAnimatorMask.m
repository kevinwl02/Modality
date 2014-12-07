//
//  MODTransitionAnimatorMask.m
//  Modality
//
//  Created by Kevin on 30/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitionAnimatorMask.h"

static CGFloat const kMaskSizeSmall = 30;

@implementation MODTransitionAnimatorMask

+ (MODTransitionAnimatorMask *)transitionAnimatorWithMaskImage:(UIImage *)maskImage {
    
    MODTransitionAnimatorMask *transitionAnimator = [MODTransitionAnimatorMask new];
    transitionAnimator.maskImage = maskImage;
    
    return transitionAnimator;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];

    CGFloat animationDuration = self.transitionDuration;
    
    CGSize smallSize = CGSizeMake(kMaskSizeSmall, kMaskSizeSmall);
    CGFloat maskFullSize = MAX(containerView.frame.size.height, containerView.frame.size.width);
    if (maskFullSize > 1000) {
        maskFullSize += 500;
    }
    CGSize bigSize = CGSizeMake(maskFullSize * 3, maskFullSize * 3);
    
    if (self.isPresenting) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:toView];

            [self animateView:toView withMaskAnimationWithImage:self.maskImage duration:animationDuration initialMaskSize:smallSize finalMaskSize:bigSize andCompletionBlock:nil];
            
            CGAffineTransform toTransform = toView.transform;
            toView.transform = CGAffineTransformMakeScale(1.07f, 1.07f);
            
            [UIView animateWithDuration:animationDuration + 0.1f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                toView.transform = toTransform;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
    }
    else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [containerView addSubview:fromView];
        
            [self animateView:fromView withMaskAnimationWithImage:self.maskImage duration:animationDuration initialMaskSize:bigSize finalMaskSize:smallSize andCompletionBlock:^{
                [transitionContext completeTransition:YES];
                [fromView removeFromSuperview];
            }];
            
            CGFloat delay = 0.1f;
            [UIView animateWithDuration:animationDuration - delay delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
                fromView.alpha = 0.f;
            } completion:nil];
    }
}

- (void)animateView:(UIView *)view withMaskAnimationWithImage:(UIImage *)image duration:(CGFloat)duration initialMaskSize:(CGSize)initialMaskSize finalMaskSize:(CGSize)finalMaskSize andCompletionBlock:(void(^)())completionBlock {
    
    CALayer *mask = [CALayer new];
    mask.contents = (__bridge id)(image.CGImage);
    mask.anchorPoint = CGPointMake(0.5f, 0.5f);
    mask.position = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
    
    mask.bounds = CGRectMake(0, 0, finalMaskSize.width, finalMaskSize.height);
    NSValue *toValue = [NSValue valueWithCGRect: mask.bounds];
    NSValue *fromValue = [NSValue valueWithCGRect: CGRectMake(0, 0, initialMaskSize.width, initialMaskSize.height)];
    view.layer.mask = mask;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        
        view.layer.mask = nil;
        if (completionBlock)
            completionBlock ();
    }];
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    maskAnimation.fromValue = fromValue;
    maskAnimation.toValue = toValue;
    maskAnimation.duration = duration;
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [mask addAnimation:maskAnimation forKey:@"bounds"];
    
    [CATransaction commit];
}

- (MODTransitionType)transitionType {
    return MODTransitionTypeModal;
}

@end

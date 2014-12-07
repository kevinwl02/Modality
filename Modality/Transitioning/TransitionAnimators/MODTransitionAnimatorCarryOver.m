//
//  MODTransitionAnimatorCarryOver.m
//  Modality
//
//  Created by Kevin on 20/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitionAnimatorCarryOver.h"
#import "MODDefaults.h"
#import "MODViewHelper.h"

@interface MODTransitionAnimatorCarryOver ()

@property (nonatomic, weak) UIView *carryOverViewSuperview;
@property (nonatomic, strong) NSArray *carryOverViewSuperviewConstraints;
@property (nonatomic, assign) NSInteger carryOverViewIndexAtSuperview;
@property (nonatomic, strong) NSArray *carryOverViewConstraints;
@property (nonatomic, assign) CGRect carryOverViewFrame;

@end

@implementation MODTransitionAnimatorCarryOver

#pragma mark - Factory methods

+ (instancetype)transitionAnimatorWithCarryOverView:(UIView *)carryOverView destinationDelegate:(UIViewController<MODCarryOverDestinationDelegate> *)destinationDelegate {
    
    MODTransitionAnimatorCarryOver *transitionAnimator = [self new];
    transitionAnimator.carryOverView = carryOverView;
    transitionAnimator.destinationDelegate = destinationDelegate;
    
    return transitionAnimator;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    NSAssert(self.carryOverView != nil, @"Carry over view cannot be nil");
    NSAssert(self.destinationDelegate != nil, @"Destination delegate cannot be nil");
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *container = [transitionContext containerView];
    
    if (self.isPresenting) {
        
        [container addSubview:fromView];
        [container addSubview:toView];
        
        UIView *destinationContainer = [self.destinationDelegate destinationContainerForTransitionAnimator];
        if (destinationContainer.superview) {
            [destinationContainer.superview layoutIfNeeded];
        }
        else {
            [destinationContainer layoutIfNeeded];
        }
        
        self.carryOverView.translatesAutoresizingMaskIntoConstraints = NO;
        CGRect fromFrame = [self.carryOverView.superview convertRect:self.carryOverView.frame toView:container];
        CGRect toFrame = [toView convertRect:destinationContainer.frame fromView:container];
        self.carryOverViewSuperview = self.carryOverView.superview;
        self.carryOverViewSuperviewConstraints = self.carryOverViewSuperview.constraints;
        self.carryOverViewFrame = fromFrame;
        self.carryOverViewConstraints = self.carryOverView.constraints;
        self.carryOverViewIndexAtSuperview = [self.carryOverViewSuperview.subviews indexOfObject:self.carryOverView];
        toView.alpha = 0;
        
        [self.carryOverView removeFromSuperview];
        [container addSubview:self.carryOverView];
        [MODViewHelper layoutView:self.carryOverView withFrame:fromFrame inOptionalContainer:container];
        [container layoutIfNeeded];
    
        [MODViewHelper layoutView:self.carryOverView withFrame:toFrame inOptionalContainer:container];
        [UIView animateWithDuration:self.transitionDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:1 options:0 animations:^{
            
            [container layoutIfNeeded];
            toView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
            
            [self.carryOverView removeFromSuperview];
            [destinationContainer addSubview:self.carryOverView];
            [MODViewHelper layoutDockIntoSuperviewForView:self.carryOverView];
            [destinationContainer layoutIfNeeded];
        }];
    }
    else {
        
        [container addSubview:toView];
        [container addSubview:fromView];
        
        [self layoutCarryOverViewBackToSuperview];
        CGRect toFrame = [self.carryOverViewSuperview convertRect:self.carryOverView.frame toView:container];
        UIView *destinationContainer = [self.destinationDelegate destinationContainerForTransitionAnimator];
        CGRect fromFrame = [fromView convertRect:destinationContainer.frame toView:container];
        
        [self.carryOverView removeFromSuperview];
        [container addSubview:self.carryOverView];
        [MODViewHelper layoutView:self.carryOverView withFrame:fromFrame inOptionalContainer:container];
        [container layoutIfNeeded];
        
        [MODViewHelper layoutView:self.carryOverView withFrame:toFrame inOptionalContainer:container];
        [UIView animateWithDuration:self.transitionDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
            
            [container layoutIfNeeded];
            fromView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
            [self layoutCarryOverViewBackToSuperview];
        }];
    }
}

- (void)layoutCarryOverViewBackToSuperview {
    
    [self.carryOverView removeFromSuperview];
    [self.carryOverViewSuperview insertSubview:self.carryOverView atIndex:self.carryOverViewIndexAtSuperview];
    [NSLayoutConstraint deactivateConstraints:self.carryOverView.constraints];
    if (self.carryOverViewConstraints)
        [NSLayoutConstraint activateConstraints:self.carryOverViewConstraints];
    if (self.carryOverViewSuperviewConstraints) {
        [NSLayoutConstraint deactivateConstraints:self.carryOverViewSuperview.constraints];
        [NSLayoutConstraint activateConstraints:self.carryOverViewSuperviewConstraints];
    }
    [self.carryOverViewSuperview layoutIfNeeded];
}

@end

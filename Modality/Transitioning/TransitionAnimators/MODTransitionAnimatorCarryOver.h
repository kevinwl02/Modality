//
//  MODTransitionAnimatorCarryOver.h
//  Modality
//
//  Created by Kevin on 20/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitioningBase.h"
#import <UIKit/UIKit.h>

/**
 *  Protocol that provides information about the destination
 *  of the transition
 */
@protocol MODCarryOverDestinationDelegate;

/**
 *  Transition animator that carries over a specified view
 *  in the initial view to a container in the destination
 *  view. Layout constraints are restored after the view is
 *  returned to it's original superview.
 */
@interface MODTransitionAnimatorCarryOver : MODTransitioningBase

/**
 *  Factory method for creating the animator.
 *
 *  @param carryOverView       The view to carry over
 *  @param destinationDelegate The class that implements
 *  MODCarryOverDestinationDelegate
 *
 *  @return A set up transition animator
 */
+ (instancetype)transitionAnimatorWithCarryOverView:(UIView *)carryOverView destinationDelegate:(UIViewController<MODCarryOverDestinationDelegate> *)destinationDelegate;

/**
 *  The view to carry over
 */
@property (nonatomic, strong) UIView *carryOverView;

/**
 *  The class that implements MODCarryOverDestinationDelegate
 */
@property (nonatomic, weak) UIViewController<MODCarryOverDestinationDelegate> *destinationDelegate;

@end

@protocol MODCarryOverDestinationDelegate <NSObject>

@required

/**
 *  Specifies a destination container for the view to
 *  carry over.
 *
 *  @return The destination container.
 */
- (UIView *)destinationContainerForTransitionAnimator;

@end

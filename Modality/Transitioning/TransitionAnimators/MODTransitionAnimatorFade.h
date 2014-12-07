//
//  MODTransitionAnimatorFade.h
//  Modality
//
//  Created by Kevin on 28/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitioningBase.h"

/**
 *  Transition animator that fades in the destination
 *  view.
 */
@interface MODTransitionAnimatorFade : MODTransitioningBase <MODTransitionAnimator, UINavigationControllerDelegate>

/**
 *  Creates a transition animator.
 *
 *  @return The created transition animator
 */
+ (instancetype)transitionAnimatior;

@end

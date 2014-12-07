//
//  UIViewController+Modality.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODTransitionAnimator.h"
#import "MODDefaults.h"

/**
 *  Main interface from which transitions are set up.
 *  Always use these methods to animate with transition animators.
 */
@interface UIViewController (Modality)

/**
 *  Presents a view controller using the specified transition
 *  configuration.
 *
 *  @param viewController     The view controller to present
 *  @param transitionAnimator The transition animator object
 *  @param duration           The duration of the transition
 *  @param completion         Completion handler for the transition
 */
- (void)MOD_presentViewController:(UIViewController *)viewController
           withTransitionAnimator:(id<MODTransitionAnimator>)transitionAnimator
                         duration:(CGFloat)duration
                       completion:(void(^)())completion;

/**
 *  Sets up a transition configuration for a view controller.
 *  Use this to set up the destination view controllers when 
 *  presenting from a segue.
 *
 *  @param transitionAnimator The transition animator object
 *  @param duration           The duration of the transition
 */
- (void)MOD_animateWithTransitionAnimator:(id<MODTransitionAnimator>)transitionAnimator
                                 duration:(CGFloat)duration;

@end

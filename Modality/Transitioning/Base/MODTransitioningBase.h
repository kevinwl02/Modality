//
//  MODTransitioningBaseDelegate.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODTransitionAnimator.h"
#import "MODDefaults.h"
#import "UIViewController+Modality.h"

/**
 *  Base transition animator that performs common tasks.
 *  This is an abstract class and must not be instantiated.
 */
@interface MODTransitioningBase : NSObject <MODTransitionAnimator>

/**
 *  The duration of the transition
 */
@property (nonatomic, assign) CGFloat transitionDuration;

/**
 *  Indicates if the current transition is for presenting.
 */
@property (nonatomic, assign, readonly) BOOL isPresenting;

/**
 *  The transition type
 */
@property (nonatomic, assign) MODTransitionType transitionType;

/**
 *  Indicates if the transition is a navigation controller
 *  transition.
 */
@property (nonatomic, assign) BOOL isNavigationAnimation;

/**
 *  Returns the default duration that the animation will
 *  take if transitionDuration is set to 
 *  MODDefaultTransitionDuration
 *
 *  @return The default transition duration
 */
- (CGFloat)defaultTransitionDuration;

@end

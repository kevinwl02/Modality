//
//  MODTransitioningDelegate.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODDirection.h"
#import "MODTransitionType.h"

/**
 *  Main protocol for transition animators
 */
@protocol MODTransitionAnimator <NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@required

/**
 *  The duration of the transition
 */
@property (nonatomic, assign) CGFloat transitionDuration;

/**
 *  The type of transition
 */
@property (nonatomic, assign) MODTransitionType transitionType;

@end

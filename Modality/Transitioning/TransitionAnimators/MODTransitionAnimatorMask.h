//
//  MODTransitionAnimatorMask.h
//  Modality
//
//  Created by Kevin on 30/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitioningBase.h"

/**
 *  Transition animator that masks the destination view
 *  with the specified image, and animates the mask to a 
 *  bigger size.
 */
@interface MODTransitionAnimatorMask : MODTransitioningBase

/**
 *  Factory method to create the transition animator with
 *  the specified mask image.
 *
 *  @param maskImage The image to mask the destination view
 *
 *  @return The set up transition animator
 */
+ (MODTransitionAnimatorMask *)transitionAnimatorWithMaskImage:(UIImage *)maskImage;

/**
 *  The image to mask the destination view
 */
@property (nonatomic, strong) UIImage *maskImage;

@end

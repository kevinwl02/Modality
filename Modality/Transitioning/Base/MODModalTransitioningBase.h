//
//  MODModalTransitioningBase.h
//  Modality
//
//  Created by Kevin on 20/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MODDirectionalTransitioningBase.h"

/**
 *  Base transition animator class for modal transitions.
 *  Performs common modal transition operations.
 *  This class by itself won't present the destination view,
 *  so instantiating this directly should be avoided.
 */
@interface MODModalTransitioningBase : MODDirectionalTransitioningBase

/**
 *  The size for the destination view that will be used
 *  for displaying it as a modal view.
 */
@property (nonatomic, assign) CGSize destinationViewSize;

/**
 *  Factory method that returns an instance of the transition
 *  animator configured with the specified parameters.
 *
 *  @param direction           The direction for the modal
 *  presentation
 *  @param destinationViewSize The size for the destination
 *  view
 *
 *  @return A set up transition animator
 */
+ (instancetype)transitionAnimatorWithDirection:(MODDirection)direction
                            destinationViewSize:(CGSize)destinationViewSize;

@end

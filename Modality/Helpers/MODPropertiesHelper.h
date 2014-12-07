//
//  MODPropertiesHelper.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODDirection.h"

/**
 *  Helper class for processing direction properties
 *  This is mainly used in the transition animator classes.
 */
@interface MODPropertiesHelper : NSObject

/**
 *  Returns the inverse direction fot a given direction.
 *
 *  @param direction The direction to inverse
 *
 *  @return The inversed direction
 */
+ (MODDirection)inverseDirectionForDirection:(MODDirection)direction;

/**
 *  Returns a reference length for a view based on direction.
 *
 *  @param view      The view to get the length from
 *  @param direction The direction to which calculate the
 *  the length
 *
 *  @return The calculated length
 */
+ (CGFloat)lengthOfView:(UIView *)view forDirection:(MODDirection)direction;

/**
 *  Returns a sign on the X axis for a direction based on
 *  views coordinate space.
 *
 *  @param direction The direction to get the sign from
 *
 *  @return The calculated sign on the X axis
 */
+ (NSInteger)signForXAxisWithDirection:(MODDirection)direction;

/**
 *  Returns a sign on the Y axis for a direction based on
 *  views coordinate space.
 *
 *  @param direction The direction to get the sign from
 *
 *  @return The calculated sign on the Y axis
 */
+ (NSInteger)signForYAxisWithDirection:(MODDirection)direction;

@end

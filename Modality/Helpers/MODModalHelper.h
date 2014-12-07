//
//  MODModalHelper.h
//  Modality
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODDirection.h"

/**
 *  Helper class for configuring modal animations.
 *  This is mainly used in the transition animator classes.
 */
@interface MODModalHelper : NSObject

/**
 *  Sets up the autolayout options of a view based on length
 *  and specified direction.
 *
 *  @param view          The view to autolayout
 *  @param containerView The super view
 *  @param length        The length to which constraint the view
 *  @param direction     The direction where the view should be
 *  placed
 *  @param offset        An additional offset for the view's
 *  position
 *
 *  @return The generated constraint related to the direction
 */
+ (NSLayoutConstraint *)setupFrameForView:(UIView *)view inContainerView:(UIView *)containerView withLength:(CGFloat)length andDirection:(MODDirection)direction offset:(CGFloat)offset;

/**
 *  Adds a background for modal transitions. This background
 *  will dismiss the destination view controller when it is
 *  tapped.
 *
 *  @param view                      The view that will contain
 *  the background
 *  @param duration                  The duration of the animation
 *  @param alpha                     The final alpha of the background
 *  @param destinationViewController The view controller that
 *  will be dismissed upon tapping the background view
 */
+ (void)addModalBackgroundAnimationToView:(UIView *)view withDuration:(CGFloat)duration alpha:(CGFloat)alpha destinationViewController:(UIViewController *)destinationViewController;

/**
 *  Removes the modal background from a view.
 *
 *  @param view     The view which contains a modal background
 *  @param duration The duration of the animation
 */
+ (void)removeModalBackgroundAnimationFromView:(UIView *)view withDuration:(CGFloat)duration;

@end

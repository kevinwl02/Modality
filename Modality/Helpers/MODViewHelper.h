//
//  MODViewHelper.h
//  Modality
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODDirection.h"

/**
 *  Helper class for configuring views.
 *  This is mainly used in the transition animator classes.
 */
@interface MODViewHelper : NSObject

+ (UIImageView *)snapshotCopyOfView:(UIView *)view;
+ (UIView *)onePixelLineStretchedSnapshotOfView:(UIView *)view withDirection:(MODDirection)direction;
+ (UIView *)viewWithBackgroundOfPixelAtPosition:(CGPoint)position inView:(UIView *)view;
+ (void)layoutView:(UIView *)view withFrame:(CGRect)frame inOptionalContainer:(UIView *)containerView;
+ (void)layoutDockIntoSuperviewForView:(UIView *)view;
+ (void)layoutTransformFrameSetHorizontalForView:(UIView *)view;
+ (void)layoutTransformFrameSetVerticalForView:(UIView *)view;
+ (NSLayoutConstraint *)layoutTransformFrameSetEqualAttribute:(NSLayoutAttribute)attribute forView:(UIView *)view constant:(CGFloat)constant;
+ (void)layoutTransformFrameSetWidthForView:(UIView *)view withPriority:(UILayoutPriority)priority;
+ (void)layoutTransformFrameSetHeightForView:(UIView *)view withPriority:(UILayoutPriority)priority;
+ (void)layoutTransformFrameSetGreaterOrEqualThan:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute view:(UIView *)view;

@end

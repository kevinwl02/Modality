//
//  MODModalHelper.m
//  Modality
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODModalHelper.h"
#import "MODViewHelper.h"
#import "MODPropertiesHelper.h"
#import <objc/runtime.h>

static CGFloat const kMinModalSpace = 45;
static NSInteger const kModalBackgroundTag = 559;
static char * const kTapGestureTargetControllerAssociationKey = "tapGestureTargetControllerAssociationKey";

@implementation MODModalHelper

+ (NSLayoutConstraint *)setupFrameForView:(UIView *)view inContainerView:(UIView *)containerView withLength:(CGFloat)length andDirection:(MODDirection)direction offset:(CGFloat)offset {
    
    view.frame = CGRectMake(0, 0, length, length);
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat widthOffset = [MODPropertiesHelper signForXAxisWithDirection:direction] * offset * length * -1;
    CGFloat heightOffset = [MODPropertiesHelper signForYAxisWithDirection:direction] * offset * length * -1;
    
    switch (direction) {
        case MODDirectionTop:
            [MODViewHelper layoutTransformFrameSetHorizontalForView:view];
            [MODViewHelper layoutTransformFrameSetHeightForView:view withPriority:UILayoutPriorityDefaultHigh];
            [MODViewHelper layoutTransformFrameSetGreaterOrEqualThan:kMinModalSpace forAttribute:NSLayoutAttributeBottom view:view];
            return [MODViewHelper layoutTransformFrameSetEqualAttribute:NSLayoutAttributeTop forView:view constant:heightOffset];
        case MODDirectionBottom:
            [MODViewHelper layoutTransformFrameSetHorizontalForView:view];
            [MODViewHelper layoutTransformFrameSetHeightForView:view withPriority:UILayoutPriorityDefaultHigh];
            [MODViewHelper layoutTransformFrameSetGreaterOrEqualThan:kMinModalSpace forAttribute:NSLayoutAttributeTop view:view];
            return [MODViewHelper layoutTransformFrameSetEqualAttribute:NSLayoutAttributeBottom forView:view constant:heightOffset];
        case MODDirectionLeft:
            [MODViewHelper layoutTransformFrameSetVerticalForView:view];
            [MODViewHelper layoutTransformFrameSetWidthForView:view withPriority:UILayoutPriorityDefaultHigh];
            [MODViewHelper layoutTransformFrameSetGreaterOrEqualThan:kMinModalSpace forAttribute:NSLayoutAttributeRight view:view];
            return [MODViewHelper layoutTransformFrameSetEqualAttribute:NSLayoutAttributeLeft forView:view constant:widthOffset];
        case MODDirectionRight:
            [MODViewHelper layoutTransformFrameSetVerticalForView:view];
            [MODViewHelper layoutTransformFrameSetWidthForView:view withPriority:UILayoutPriorityDefaultHigh];
            [MODViewHelper layoutTransformFrameSetGreaterOrEqualThan:kMinModalSpace forAttribute:NSLayoutAttributeLeft view:view];
            return [MODViewHelper layoutTransformFrameSetEqualAttribute:NSLayoutAttributeRight forView:view constant:widthOffset];
            
        default:
            return nil;
    }
}

+ (void)addModalBackgroundAnimationToView:(UIView *)view withDuration:(CGFloat)duration alpha:(CGFloat)alpha destinationViewController:(UIViewController *)destinationViewController {
    
    UIView *modalBackground = [[UIView alloc] initWithFrame:view.frame];
    modalBackground.backgroundColor = [UIColor blackColor];
    modalBackground.alpha = 0;
    modalBackground.tag = kModalBackgroundTag;
    [view addSubview:modalBackground];
    [MODViewHelper layoutDockIntoSuperviewForView:modalBackground];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modalTapGestureTriggered:)];
    [modalBackground addGestureRecognizer:tapGesture];
    objc_setAssociatedObject(tapGesture, kTapGestureTargetControllerAssociationKey, destinationViewController, OBJC_ASSOCIATION_RETAIN);
    
    [UIView animateWithDuration:duration animations:^{
        
        modalBackground.alpha = alpha;
    } completion:nil];
}

+ (void)removeModalBackgroundAnimationFromView:(UIView *)view withDuration:(CGFloat)duration {
    
    UIView *modalBackground = [view viewWithTag:kModalBackgroundTag];
    
    [UIView animateWithDuration:duration animations:^{
        
        modalBackground.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            [modalBackground removeFromSuperview];
        }
    }];
}

#pragma mark - Private methods

+ (void)modalTapGestureTriggered:(UITapGestureRecognizer *)tapGesture {
    
    UIViewController *destinationViewController = objc_getAssociatedObject(tapGesture, kTapGestureTargetControllerAssociationKey);
    [destinationViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

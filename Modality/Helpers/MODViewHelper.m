//
//  MODViewHelper.m
//  Modality
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODViewHelper.h"

@implementation MODViewHelper

#pragma mark - Public methods

+ (UIImageView *)snapshotCopyOfView:(UIView *)view {

    UIImage *imageSnapshot = [self imageSnapshotForView:view];
    
    UIImageView *snapshotView = [[UIImageView alloc] initWithFrame:view.frame];
    snapshotView.image = imageSnapshot;
    snapshotView.contentMode = UIViewContentModeScaleToFill;
    
    return snapshotView;
}

+ (UIView *)onePixelLineStretchedSnapshotOfView:(UIView *)view withDirection:(MODDirection)direction {
    
    UIImage *snapshot = [self imageSnapshotForView:view];
    CGFloat scale = snapshot.scale;
    
    CGRect cropRect = CGRectZero;
    switch (direction) {
        case MODDirectionTop:
            cropRect = CGRectMake(0, 0, view.frame.size.width*scale, scale);
            break;
        case MODDirectionBottom:
            cropRect = CGRectMake(0, view.frame.size.height*scale - scale, view.frame.size.width*scale, scale);
            break;
        case MODDirectionLeft:
            cropRect = CGRectMake(0, 0, scale, view.frame.size.height*scale);
            break;
        case MODDirectionRight:
            cropRect = CGRectMake(view.frame.size.width*scale - scale, 0, scale, view.frame.size.height*scale);
            break;
            
        default:
            break;
    }
    
    CGImageRef croppedImage = CGImageCreateWithImageInRect(snapshot.CGImage, cropRect);
    UIImage *oneLineImage = [UIImage imageWithCGImage:croppedImage scale:scale orientation:snapshot.imageOrientation];
    CGImageRelease(croppedImage);
    
    UIImageView *stretchedSnapshotView = [[UIImageView alloc] initWithFrame:view.frame];
    stretchedSnapshotView.image = oneLineImage;
    stretchedSnapshotView.contentMode = UIViewContentModeScaleToFill;
    
    return stretchedSnapshotView;
}

+ (UIView *)viewWithBackgroundOfPixelAtPosition:(CGPoint)position inView:(UIView *)view {
    
    UIImage *snapshot = [self imageSnapshotForView:view];
    const UInt8 * pixelData = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(snapshot.CGImage)));
    int pixelPosition = (snapshot.size.width * position.y + position.x) * 4;
    
    UIView *colorView = [[UIView alloc] initWithFrame:view.frame];
    view.backgroundColor = [UIColor colorWithRed:pixelData[pixelPosition]/255.0 green:pixelData[pixelPosition + 1]/255.0 blue:pixelData[pixelPosition + 2]/255.0 alpha:pixelData[pixelPosition + 3]/255.0];
    
    CFRelease(pixelData);
    return colorView;
}

+ (void)layoutView:(UIView *)view withFrame:(CGRect)frame inOptionalContainer:(UIView *)containerView {
    
    [self removeSizeConstraintsOfView:view];
    
    if (containerView) {
        [NSLayoutConstraint deactivateConstraints:containerView.constraints];
    }
    
    [self horizontalLayoutView:view withFrame:frame];
    [self verticalLayoutView:view withFrame:frame];
}

+ (void)layoutDockIntoSuperviewForView:(UIView *)view {
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self removeSizeConstraintsOfView:view];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [NSLayoutConstraint activateConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}

+ (void)layoutTransformFrameSetHorizontalForView:(UIView *)view {
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}

+ (void)layoutTransformFrameSetVerticalForView:(UIView *)view {
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}

+ (NSLayoutConstraint *)layoutTransformFrameSetEqualAttribute:(NSLayoutAttribute)attribute forView:(UIView *)view constant:(CGFloat)constant {
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:attribute multiplier:1 constant:constant];
    constraint.active = YES;
    
    return constraint;
}

+ (void)layoutTransformFrameSetWidthForView:(UIView *)view withPriority:(UILayoutPriority)priority {
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:view.bounds.size.width];
    constraint.priority = priority;
    constraint.active = YES;
}

+ (void)layoutTransformFrameSetHeightForView:(UIView *)view withPriority:(UILayoutPriority)priority {
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:view.bounds.size.height];
    constraint.priority = priority;
    constraint.active = YES;
}

+ (void)layoutTransformFrameSetGreaterOrEqualThan:(CGFloat)value forAttribute:(NSLayoutAttribute)attribute view:(UIView *)view {
    
    NSLayoutRelation relation = NSLayoutRelationGreaterThanOrEqual;
    if (attribute == NSLayoutAttributeRight || attribute == NSLayoutAttributeBottom) {
        relation = NSLayoutRelationLessThanOrEqual;
        value *= -1;
    }
    [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:relation toItem:view.superview attribute:attribute multiplier:1 constant:value].active = YES;
}

#pragma mark - Private methods

+ (UIImage *)imageSnapshotForView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

+ (void)horizontalLayoutView:(UIView *)view withFrame:(CGRect)frame {
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-l-[view(==w)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{
                                                                                                                                                                            @"l":@(frame.origin.x),
                                                                                                                                                                            @"w":@(frame.size.width)
                                                                                                                                                                            }views:NSDictionaryOfVariableBindings(view)]];
}

+ (void)verticalLayoutView:(UIView *)view withFrame:(CGRect)frame {
    
    [NSLayoutConstraint activateConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-t-[view(==h)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{
                                                                                                                                                                             @"t":@(frame.origin.y),
                                                                                                                                                                             @"h":@(frame.size.height)
                                                                                                                                                                             }views:NSDictionaryOfVariableBindings(view)]];
}

+ (void)removeSizeConstraintsOfView:(UIView *)view {
    
    for (NSLayoutConstraint *constraint in view.constraints) {
        
        if (constraint.firstItem == view &&
            (constraint.firstAttribute == NSLayoutAttributeHeight
             || constraint.firstAttribute == NSLayoutAttributeWidth)) {
                
                constraint.active = NO;
            }
    }
}

@end

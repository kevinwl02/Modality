//
//  MODTransformFactory.m
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransformFactory.h"
#import "MODPropertiesHelper.h"

@implementation MODTransformFactory

+ (CGAffineTransform)translateTransformWithTransform:(CGAffineTransform)transform distance:(NSInteger)distance direction:(MODDirection)direction {
    
    CGFloat translateX = [MODPropertiesHelper signForXAxisWithDirection:direction] * distance;
    CGFloat translateY = [MODPropertiesHelper signForYAxisWithDirection:direction] * distance;
    
    return CGAffineTransformTranslate(transform, translateX, translateY);
}

@end

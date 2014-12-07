//
//  MODTransformFactory.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODDirection.h"

/**
 *  Utility class for creating transforms.
 *  This is only used inside the transition animator classes.
 */
@interface MODTransformFactory : NSObject

/**
 *  Returns a CGAffineTransform translated to the
 *  specified direction.
 *
 *  @param transform The initial transform to which the 
 *  translation will be applied
 *  @param distance  The distance of the translation
 *  @param direction The direction of the translation
 *
 *  @return The calculated transform
 */
+ (CGAffineTransform)translateTransformWithTransform:(CGAffineTransform)transform distance:(NSInteger)distance direction:(MODDirection)direction;

@end

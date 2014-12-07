//
//  MODPropertiesHelper.m
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODPropertiesHelper.h"

@implementation MODPropertiesHelper

+ (MODDirection)inverseDirectionForDirection:(MODDirection)direction {
    
    switch (direction) {
        case MODDirectionTop:
            return MODDirectionBottom;
        case MODDirectionBottom:
            return MODDirectionTop;
        case MODDirectionLeft:
            return MODDirectionRight;
        case MODDirectionRight:
            return MODDirectionLeft;
            
        default:
            return MODDirectionTop;
    }
}

+ (CGFloat)lengthOfView:(UIView *)view forDirection:(MODDirection)direction {
    
    CGSize viewSize = view.bounds.size;
    
    switch (direction) {
        case MODDirectionTop:
        case MODDirectionBottom:
            return viewSize.height;
        case MODDirectionLeft:
        case MODDirectionRight:
            return viewSize.width;
            
        default:
            return 0;
    }
}

+ (NSInteger)signForXAxisWithDirection:(MODDirection)direction {
    
    switch (direction) {
        case MODDirectionTop:
        case MODDirectionBottom:
            return 0;
        case MODDirectionLeft:
            return 1;
        case MODDirectionRight:
            return -1;
            
        default:
            return 0;
    }
}

+ (NSInteger)signForYAxisWithDirection:(MODDirection)direction {
    
    switch (direction) {
        case MODDirectionTop:
            return 1;
        case MODDirectionBottom:
            return -1;
        case MODDirectionLeft:
        case MODDirectionRight:
            return 0;
            
        default:
            return 0;;
    }
}

@end

//
//  MODTransitionType.h
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Determines if the view controller that initiates the
 *  transition will stay on screen after the transition is
 *  completed.
 */
typedef NS_ENUM(NSInteger, MODTransitionType) {
 
    /**
     *  Initial view controller won't stay.
     */
    MODTransitionTypeFullScreen,
    
    /**
     *  Initial view controller will stay.
     */
    MODTransitionTypeModal
};

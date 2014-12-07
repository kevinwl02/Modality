//
//  MODDirectionalTransitioningBase.h
//  Modality
//
//  Created by Kevin on 20/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "MODTransitioningBase.h"

/**
 *  Base transition animator for transitions that use
 *  direction.
 *  This is an abstract class and must not be instantiated.
 */
@interface MODDirectionalTransitioningBase : MODTransitioningBase

/**
 *  The direction of the transition
 */
@property (nonatomic, assign) MODDirection direction;

@end

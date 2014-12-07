//
//  UIViewController+Modality.m
//  Modality
//
//  Created by Kevin on 12/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "UIViewController+Modality.h"
#import <objc/runtime.h>
#import "MODDefaults.h"
#import "MODTransitionAnimator.h"

static char * const kTransitioningDelegateAssociationKey = "MODTransitionAnimatorAssociationKey";

@implementation UIViewController (Modality)

- (void)MOD_presentViewController:(UIViewController *)viewController
           withTransitionAnimator:(id<MODTransitionAnimator>)transitionAnimator
                         duration:(CGFloat)duration
                       completion:(void(^)())completion {
    
    [self setupDestinationViewController:viewController
                  withTransitionAnimator:transitionAnimator
                                duration:duration];
    [self presentViewController:viewController animated:YES completion:completion];
}

- (void)MOD_animateWithTransitionAnimator:(id<MODTransitionAnimator>)transitionAnimator
                                 duration:(CGFloat)duration {
    
    [self setupDestinationViewController:self
                  withTransitionAnimator:transitionAnimator
                                duration:duration];
}

- (void)setupDestinationViewController:(UIViewController *)destinationViewController
                withTransitionAnimator:(id<MODTransitionAnimator>)transitionAnimator
                              duration:(CGFloat)duration {
    
    switch (transitionAnimator.transitionType) {
        case MODTransitionTypeFullScreen:
            break;
        case MODTransitionTypeModal:
            destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
            break;
            
        default:
            break;
    }
    
    transitionAnimator.transitionDuration = duration;
    destinationViewController.transitioningDelegate = transitionAnimator;
    objc_setAssociatedObject(destinationViewController, kTransitioningDelegateAssociationKey, transitionAnimator, OBJC_ASSOCIATION_RETAIN);
}

@end

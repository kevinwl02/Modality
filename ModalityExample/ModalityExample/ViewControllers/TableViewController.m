//
//  TableViewController.m
//  ModalityExample
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "TableViewController.h"
#import "DirectionButton.h"
#import "MODTransitionAnimatorSlideModal.h"
#import "MODTransitionAnimatorFlipModal.h"
#import "MODTransitionAnimatorFade.h"
#import "MODTransitionAnimatorMask.h"
#import "MODTransitionAnimatorCarryOver.h"
#import "CarryOverViewController.h"

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet DirectionButton *slideUp;
@property (weak, nonatomic) IBOutlet DirectionButton *slideDown;
@property (weak, nonatomic) IBOutlet DirectionButton *slideRight;
@property (weak, nonatomic) IBOutlet DirectionButton *slideLeft;

@property (weak, nonatomic) IBOutlet DirectionButton *flipUp;
@property (weak, nonatomic) IBOutlet DirectionButton *flipRight;
@property (weak, nonatomic) IBOutlet DirectionButton *flipLeft;
@property (weak, nonatomic) IBOutlet DirectionButton *flipDown;

@property (weak, nonatomic) IBOutlet DirectionButton *fade;

@property (weak, nonatomic) IBOutlet DirectionButton *mask1;
@property (weak, nonatomic) IBOutlet DirectionButton *mask2;

@property (weak, nonatomic) IBOutlet DirectionButton *carryOver;
@property (weak, nonatomic) IBOutlet UIView *carryOverView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupInput];
}

#pragma mark - Input setup

- (void)setupInput {
    
    [self setupSlide];
    [self setupFlip];
    [self setupMask];
}

- (void)setupSlide {
    self.slideUp.tag = MODDirectionTop;
    [self.slideUp addTarget:self action:@selector(slideModal:) forControlEvents:UIControlEventTouchUpInside];
    self.slideDown.tag = MODDirectionBottom;
    [self.slideDown addTarget:self action:@selector(slideModal:) forControlEvents:UIControlEventTouchUpInside];
    self.slideRight.tag = MODDirectionRight;
    [self.slideRight addTarget:self action:@selector(slideModal:) forControlEvents:UIControlEventTouchUpInside];
    self.slideLeft.tag = MODDirectionLeft;
    [self.slideLeft addTarget:self action:@selector(slideModal:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupFlip {
    self.flipUp.tag = MODDirectionTop;
    [self.flipUp addTarget:self action:@selector(flipModal:) forControlEvents:UIControlEventTouchUpInside];
    self.flipDown.tag = MODDirectionBottom;
    [self.flipDown addTarget:self action:@selector(flipModal:) forControlEvents:UIControlEventTouchUpInside];
    self.flipRight.tag = MODDirectionRight;
    [self.flipRight addTarget:self action:@selector(flipModal:) forControlEvents:UIControlEventTouchUpInside];
    self.flipLeft.tag = MODDirectionLeft;
    [self.flipLeft addTarget:self action:@selector(flipModal:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupMask {
    
    self.mask1.tag = 0;
    [self.mask1 addTarget:self action:@selector(maskPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mask2.tag = 1;
    [self.mask2 addTarget:self action:@selector(maskPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Navigation

/**
 *  This is how to add transitions when the view controllers are presented 
 *  manually.
 *
 */
- (void)slideModal:(UIButton *)button {
    
    UIViewController *modalController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    
    MODTransitionAnimatorSlideModal *animator = [MODTransitionAnimatorSlideModal transitionAnimatorWithDirection:button.tag destinationViewSize:CGSizeMake(self.view.bounds.size.width, 150)];
    [self MOD_presentViewController:modalController withTransitionAnimator:animator duration:MODDefaulTransitionDuration completion:nil];
}

- (void)flipModal:(UIButton *)button {
    
    UIViewController *modalController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    
    MODTransitionAnimatorFlipModal *animator = [MODTransitionAnimatorFlipModal transitionAnimatorWithDirection:button.tag destinationViewSize:CGSizeMake(self.view.bounds.size.width, 150)];
    [self MOD_presentViewController:modalController withTransitionAnimator:animator duration:MODDefaulTransitionDuration completion:nil];
}

- (void)maskPressed:(UIButton *)button {
    
    UIImage *maskImage = nil;
    if (button.tag == 0) {
        maskImage = [UIImage imageNamed:@"circleMask"];
    }
    else if (button.tag == 1) {
        maskImage = [UIImage imageNamed:@"starMask"];
    }
    
    UIViewController *destinationViewContorller = [self.storyboard instantiateViewControllerWithIdentifier:@"LogoViewController"];
    MODTransitionAnimatorMask *animator = [MODTransitionAnimatorMask transitionAnimatorWithMaskImage:maskImage];
    [self MOD_presentViewController:destinationViewContorller withTransitionAnimator:animator duration:MODDefaulTransitionDuration completion:nil];
}

/**
 *  This is how to do it when navigating through segues.
 *
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"FadeSegue"]) {
        
        MODTransitionAnimatorFade *animator = [MODTransitionAnimatorFade transitionAnimatior];
        UIViewController *destinationController = segue.destinationViewController;
        [destinationController MOD_animateWithTransitionAnimator:animator duration:MODDefaulTransitionDuration];
    }
    else if ([segue.identifier isEqualToString:@"CarryOverSegue"]) {
        
        CarryOverViewController *destinationController = segue.destinationViewController;
        MODTransitionAnimatorCarryOver *animator = [MODTransitionAnimatorCarryOver transitionAnimatorWithCarryOverView:self.carryOverView destinationDelegate:destinationController];
        [destinationController MOD_animateWithTransitionAnimator:animator duration:MODDefaulTransitionDuration];
    }
}

@end

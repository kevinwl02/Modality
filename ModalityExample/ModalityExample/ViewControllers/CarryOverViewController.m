//
//  CarryOverViewController.m
//  ModalityExample
//
//  Created by Kevin on 07/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "CarryOverViewController.h"

@interface CarryOverViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CarryOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - UI

- (IBAction)goBackPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MODCarryOverDestinationDelegate

- (UIView *)destinationContainerForTransitionAnimator {
    
    return self.containerView;
}

@end

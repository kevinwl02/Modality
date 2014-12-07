//
//  FadeViewController.m
//  ModalityExample
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "FadeViewController.h"
#import "DirectionButton.h"

@interface FadeViewController ()

@property (weak, nonatomic) IBOutlet DirectionButton *okButton;

@end

@implementation FadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.okButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)okButtonPressed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

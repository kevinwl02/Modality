//
//  directionButton.m
//  ModalityExample
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "DirectionButton.h"

@implementation DirectionButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

#pragma mark - Private methods

- (void)setupView {
    
    self.layer.cornerRadius = 4;
    [self addTarget:self action:@selector(enlargeButton) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(shrinkButton) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(shrinkButton) forControlEvents:UIControlEventTouchDragExit];
}

- (void)enlargeButton {
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)shrinkButton {
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

@end

//
//  CellContentView.m
//  ModalityExample
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "CellContentView.h"

@implementation CellContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

#pragma mark - Private methods

- (void)setupView {
    
    self.layer.cornerRadius = 3;
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0.5, 1);
}

@end

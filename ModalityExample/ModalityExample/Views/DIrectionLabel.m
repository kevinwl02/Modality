//
//  DIrectionLabel.m
//  ModalityExample
//
//  Created by Kevin on 06/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "DIrectionLabel.h"

@implementation DIrectionLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

#pragma mark - Private methods

- (void)setupView {
 
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = [UIColor colorWithRed:247/255.0 green:112/255.0 blue:141/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 10;
}

@end

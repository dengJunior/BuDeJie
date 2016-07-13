//
//  JKThirdLoginBtn.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKThirdLoginBtn.h"

@implementation JKThirdLoginBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = 0;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = (self.width - self.titleLabel.width) / 2;
    self.titleLabel.y = self.height - self.titleLabel.height;
}

@end

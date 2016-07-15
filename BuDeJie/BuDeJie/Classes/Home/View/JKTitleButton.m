//
//  JKTitleButton.m
//  BuDeJie
//
//  Created by Joker on 16/7/15.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTitleButton.h"

@implementation JKTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    // 设置按钮颜色
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    // 设置按钮字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

/** 高亮状态什么都不做（取消高亮状态） */
- (void)setHighlighted:(BOOL)highlighted {}

@end

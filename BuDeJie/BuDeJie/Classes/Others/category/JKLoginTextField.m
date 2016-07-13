//
//  JKLoginTextField.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKLoginTextField.h"

@implementation JKLoginTextField

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    
    [self setup];
}

- (void)setup {
    // 主题颜色（反应在TextField上主要是光标的颜色）
    self.tintColor = [UIColor whiteColor];
    // 设置初始状态下占位文字的颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    
    // 监听编辑状态
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)editBegin {
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor whiteColor];
}

- (void)editEnd {
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor lightGrayColor];
}

@end

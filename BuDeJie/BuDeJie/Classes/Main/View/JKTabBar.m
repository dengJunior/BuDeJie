//
//  JKTabBar.m
//  BuDeJie
//
//  Created by Joker on 16/7/8.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTabBar.h"

@interface JKTabBar ()

@property (nonatomic, strong) UIButton *publishBtn;

/** 上一次点击的tabBarButton */
@property (nonatomic, weak) UIControl *previousSelectedTabBarButton;

@end

@implementation JKTabBar

- (UIButton *)publishBtn {
    
    if (_publishBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *imageNor = [UIImage imageNamed:@"tabBar_publish_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageHL = [UIImage imageNamed:@"tabBar_publish_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
        
        [btn setImage:imageNor forState:UIControlStateNormal];
        [btn setImage:imageHL forState:UIControlStateHighlighted];
        
        // 根据内容自动计算自己的大小
        [btn sizeToFit];
        [self addSubview:btn];
        _publishBtn = btn;
    }
    return _publishBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = 5;
    NSInteger i = 0;
    
    CGFloat width = screenW / count;
    CGFloat height = self.height;
    for (UIControl *tabBarButton in self.subviews) {
        // UITabBarButton类属于私有API，敲不出来的
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        if (self.previousSelectedTabBarButton == nil && i == 0) {
            self.previousSelectedTabBarButton = tabBarButton;
        }
        
        if (i == 2) {
            i++;
        }
        tabBarButton.frame = CGRectMake(width * i, 0, width, height);
        i++;
        
        // 给tabBarButton添加事件
        [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
//    JKLog(@"%@", NSStringFromCGPoint(self.center))
//    self.publishBtn.center = self.center; // self.center是以屏幕左上角为原点计算的
    self.publishBtn.center = CGPointMake(screenW * 0.5, height * 0.5);
}

/** tabBarButton点击事件 */
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if (self.previousSelectedTabBarButton == tabBarButton) {
        // 当前点击的按钮是上次点击的按钮 -> 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:JKTabBarButtonReclickedNotification object:nil];
    }
    // 修改上一次点击的tabBarButton指针
    self.previousSelectedTabBarButton = tabBarButton;
}

@end

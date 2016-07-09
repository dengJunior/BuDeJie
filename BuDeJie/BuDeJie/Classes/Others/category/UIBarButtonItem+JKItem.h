//
//  UIBarButtonItem+JKItem.h
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JKItem)

/**
 *  创建一个UIBarButtonItem对象
 *
 *  @param image   普通状态下显示的图片
 *  @param hlImage 高亮状态下显示的图片
 *  @param target  点击事件发生时执行任务的对象
 *  @param action  点击事件发生时需要执行的任务
 *
 *  该方法创建的UIBarButtonItem对象响应UIControlEventTouchUpInside事件
 *
 *  @return 返回一个UIBarButtonItem对象
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)hlImage target:(id)target action:(SEL)action;

@end

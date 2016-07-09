//
//  UIBarButtonItem+JKItem.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "UIBarButtonItem+JKItem.h"

@implementation UIBarButtonItem (JKItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)hlImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlImage forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end

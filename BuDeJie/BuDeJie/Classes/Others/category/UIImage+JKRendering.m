//
//  UIImage+JKRendering.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "UIImage+JKRendering.h"

@implementation UIImage (JKRendering)

+ (UIImage *)imageNamed:(NSString *)imageName WithRendingMode:(UIImageRenderingMode)mode {
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:mode];
}

+ (UIImage *)circleImageWithOriginalImage:(UIImage *)oriImage {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(oriImage.size, NO, 0);
    // 绘制裁剪范围
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, oriImage.size.width, oriImage.size.height)];
    // 裁剪
    [path addClip];
    // 绘图
    [oriImage drawAtPoint:CGPointZero];
    // 从上下文取出图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

@end

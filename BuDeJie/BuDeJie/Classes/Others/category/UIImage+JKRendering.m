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
    
    UIImage *newImage = [UIImage antialiasImageWithOriginImage:oriImage];
    
    // 预留边宽（防锯齿）
//    CGFloat border = 1;
    // 上下文大小
//    CGSize size = CGSizeMake(oriImage.size.width + border *2, oriImage.size.height + border *2);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(newImage.size, NO, 0);
    // 绘制裁剪范围
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, newImage.size.width, newImage.size.height)];
    // 裁剪
    [path addClip];
    // 绘图
    [oriImage drawAtPoint:CGPointMake(0, 0)];
    // 从上下文取出图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

+ (UIImage *)antialiasImageWithOriginImage:(UIImage *)oriImage {
    
    CGSize smallSize = CGSizeMake(oriImage.size.width -2, oriImage.size.height -2);
    UIGraphicsBeginImageContextWithOptions(smallSize, NO, 0);
    [oriImage drawInRect:CGRectMake(-1, -1, oriImage.size.width, oriImage.size.height)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(oriImage.size, NO, 0);
    [smallImage drawInRect:CGRectMake(1, 1, smallSize.width, smallSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

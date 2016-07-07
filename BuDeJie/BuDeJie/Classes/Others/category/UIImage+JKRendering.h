//
//  UIImage+JKRendering.h
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRendering)

/**
 *  根据图片名和渲染方式生成一个UIImage对象
 *
 *  @param imageName 图片名
 *  @param mode      渲染方式
 *
 *  @code
 *  渲染方式有：
 *  UIImageRenderingModeAutomatic,        自动渲染
 *  UIImageRenderingModeAlwaysOriginal,   不渲染，返回原图
 *  UIImageRenderingModeAlwaysTemplate,   按模板渲染
 *  @endcode
 *
 *  @return 返回一个UIImage对象
 */
+ (UIImage *)imageNamed:(NSString *)imageName WithRendingMode:(UIImageRenderingMode)mode;

@end

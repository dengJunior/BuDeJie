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

@end

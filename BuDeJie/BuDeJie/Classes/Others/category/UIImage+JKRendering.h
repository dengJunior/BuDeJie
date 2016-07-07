//
//  UIImage+JKRendering.h
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRendering)

+ (UIImage *)imageNamed:(NSString *)imageName WithRendingMode:(UIImageRenderingMode)mode;

@end

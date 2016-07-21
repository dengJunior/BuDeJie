//
//  UIImageView+JKDownload.h
//  BuDeJie
//
//  Created by Joker on 16/7/21.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (JKDownload)

/**
 *  封装SDWebImage框架，给imageView设置图片
 *
 *  @param originalImageURL  原图的URL字符串
 *  @param thumbnailImageURL 缩略图的URL字符串
 *  @param placeholderImage  占位图片
 *  @param completedBlock    操作请求完成后的回调block块
 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  封装SDWebImage框架，给imageView设置图片
 *
 *  @param originalImageURL  原图的URL字符串
 *  @param thumbnailImageURL 缩略图的URL字符串
 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL;

/**
 *  封装SDWebImage框架，给imageView设置图片
 *
 *  @param originalImageURL  原图的URL字符串
 *  @param thumbnailImageURL 缩略图的URL字符串
 *  @param placeholderImage  占位图片
 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage;

/**
 *  封装SDWebImage框架，给imageView设置图片
 *
 *  @param originalImageURL  原图的URL字符串
 *  @param thumbnailImageURL 缩略图的URL字符串
 *  @param completedBlock    操作请求完成后的回调block块
 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock;

@end

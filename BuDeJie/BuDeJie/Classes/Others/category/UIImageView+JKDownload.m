//
//  UIImageView+JKDownload.m
//  BuDeJie
//
//  Created by Joker on 16/7/21.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "UIImageView+JKDownload.h"
#import <SDImageCache.h>
#import <AFNetworkReachabilityManager.h>

/*
 sd_setImageWithURL...的执行
 1.取消该imageView之前的下载请求
 2.设置占位图片到imageView
 3.检查缓存中是否已经下载该图片，有就设置给imageView
    在缓存中以字典形式存储的，key为URL的字符串，value为image对象
 4.如果缓存中没有，发请求下载
 */

@implementation UIImageView (JKDownload)

/** 需要占位图片，也需要完成后的回调block块 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock {
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *originImage = [imageCache imageFromDiskCacheForKey:originalImageURL];
    if (originImage) {
        // 缓存中有大图，直接显示大图
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
    } else {
        // 缓存中没有大图
        AFNetworkReachabilityManager *manager =[AFNetworkReachabilityManager sharedManager];
        if (manager.isReachableViaWiFi) {
            // wifi网络环境
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
        } else if (manager.isReachableViaWWAN){
            // 手机网络环境
            // 判断是否设置了3G/4G仍然下载大图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) {
                // 设置了总是下载大图
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completedBlock];
            } else {
                // 没有设置手机网络仍下载大图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
            }
        } else {
            // 断网 -> 检查缓存中是否有小图，有就直接用，没有就下载小图
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
        }
    }
}

/** 不需要占位图片，也不需要完成后的回调block块 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL {

    [self jk_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:nil];
}

/** 需要占位图片，不需要完成后的回调block块 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage {
    
    [self jk_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:placeholderImage completed:nil];
}

/** 不需要占位图片，需要完成后的回调block块 */
- (void)jk_setImageWithOriginalImageURL:(NSString *)originalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL completed:(SDWebImageCompletionBlock)completedBlock {
    [self jk_setImageWithOriginalImageURL:originalImageURL thumbnailImageURL:thumbnailImageURL placeholderImage:nil completed:completedBlock];
}

@end

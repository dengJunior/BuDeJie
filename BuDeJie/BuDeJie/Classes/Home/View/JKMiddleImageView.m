//
//  JKMiddleImageView.m
//  BuDeJie
//
//  Created by Joker on 16/7/20.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMiddleImageView.h"
#import "JKTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <AFNetworkReachabilityManager.h>

@interface JKMiddleImageView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation JKMiddleImageView

+ (instancetype)imageView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions][0];
}

- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    // 设置显示的图片
    // 初始化
    _imageView.image = nil;
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *originImage = [imageCache imageFromDiskCacheForKey:topicItem.image1];
    if (originImage) {
        // 缓存中有大图，直接显示大图
        _imageView.image = originImage;
    } else {
        // 缓存中没有大图
        AFNetworkReachabilityStatus status =[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            // wifi网络环境
            [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image1]];
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            // 手机网络环境
            UIImage *thumbImage = [imageCache imageFromDiskCacheForKey:topicItem.image0];
            if (thumbImage) {
                // 有小图缓存
                _imageView.image = thumbImage;
            } else {
                // 没有小图缓存，下载小图
                [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
            }
        }
        // 断网，维持初始化时设置的图片
    }
    
    // 是否长图
    if (topicItem.bigImageH) {
        _seeBigButton.hidden = NO;
        _imageView.contentMode = UIViewContentModeTop;
        _imageView.clipsToBounds = YES;
    } else {
        _seeBigButton.hidden = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = NO;
    }
    
}

@end

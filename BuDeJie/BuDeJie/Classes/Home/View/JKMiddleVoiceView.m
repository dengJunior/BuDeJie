//
//  JKMiddleVoiceView.m
//  BuDeJie
//
//  Created by Joker on 16/7/19.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMiddleVoiceView.h"
#import "JKTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <AFNetworkReachabilityManager.h>

@interface JKMiddleVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation JKMiddleVoiceView

+ (instancetype)voiceView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions][0];
}

- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    // 设置显示的图片
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
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
    
    // 设置播放次数
    NSString *playcountStr;
    if (_topicItem.playcount > 10000) {
        playcountStr = [NSString stringWithFormat:@"%.1f万播放", _topicItem.playcount / 10000.0];
    } else if (_topicItem.playcount > 0) {
        playcountStr = [NSString stringWithFormat:@"%zd播放", _topicItem.playcount];
    }
    playcountStr = [playcountStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    _playcountLabel.text = playcountStr;
    
    // 设置音频时长
    _voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _topicItem.voicetime / 60, _topicItem.voicetime % 60];
}

@end

//
//  JKMiddleVideoView.m
//  BuDeJie
//
//  Created by Joker on 16/7/20.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMiddleVideoView.h"
#import "JKTopicItem.h"
#import <SDImageCache.h>
#import <UIImageView+WebCache.h>
#import <AFNetworkReachabilityManager.h>

@interface JKMiddleVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation JKMiddleVideoView

+ (instancetype)videoView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions][0];
}

- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    // 设置显示的图片
    [_imageView jk_setImageWithOriginalImageURL:topicItem.image1 thumbnailImageURL:topicItem.image0];
    
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
    _videotimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _topicItem.videotime / 60, _topicItem.videotime % 60];
}


@end

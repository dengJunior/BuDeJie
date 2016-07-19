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
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    
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

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
#import "JKBigPictureViewController.h"

@interface JKMiddleVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation JKMiddleVoiceView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [_imageView addGestureRecognizer:tap];
}

+ (instancetype)voiceView {
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
    _voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _topicItem.voicetime / 60, _topicItem.voicetime % 60];
}

#pragma mark -
#pragma mark 事件处理
- (void)seeBigPicture {
    JKBigPictureViewController *bigPictureVc = [[JKBigPictureViewController alloc] init];
    bigPictureVc.topicItem = self.topicItem;
    [self.window.rootViewController presentViewController:bigPictureVc animated:YES completion:nil];
}

@end

//
//  JKTopicCell.m
//  BuDeJie
//
//  Created by Joker on 16/7/18.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTopicCell.h"
#import "JKTopicItem.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

#import "JKMiddleVoiceView.h"
#import "JKMiddleVideoView.h"
#import "JKMiddleImageView.h"

@interface JKTopicCell ()

/** 头像 */
@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
/** 通过时间 */
@property (nonatomic, weak) IBOutlet UILabel *passtimeLabel;
/** 正文 */
@property (nonatomic, weak) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最热评论 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/** 声音类cell的中部视图 */
@property (nonatomic, weak) JKMiddleVoiceView *middleVoiceView;
/** 视频类cell的中部视图 */
@property (nonatomic, weak) JKMiddleVideoView *middleVideoView;
/** 图片类cell的中部视图 */
@property (nonatomic, weak) JKMiddleImageView *middleImageView;

@end

@implementation JKTopicCell

/** 中间声音控件的懒加载 */
- (JKMiddleVoiceView *)middleVoiceView {
    if (!_middleVoiceView) {
        JKMiddleVoiceView *middleVoiceView = [JKMiddleVoiceView voiceView];
        middleVoiceView.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:middleVoiceView];
        _middleVoiceView = middleVoiceView;
    }
    return _middleVoiceView;
}
/** 中间视频控件的懒加载 */
- (JKMiddleVideoView *)middleVideoView {
    if (!_middleVideoView) {
        JKMiddleVideoView *middleVideoView = [JKMiddleVideoView videoView];
        middleVideoView.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:middleVideoView];
        _middleVideoView = middleVideoView;
    }
    return _middleVideoView;
}
/** 中间图片控件的懒加载 */
- (JKMiddleImageView *)middleImageView {
    if (!_middleImageView) {
        JKMiddleImageView *middleImageView = [JKMiddleImageView imageView];
        middleImageView.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:middleImageView];
        _middleImageView = middleImageView;
    }
    return _middleImageView;
}

/** 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (self.topicItem.type) {
        case JKTopicStyleVideo: {
            self.middleVoiceView.hidden = YES;
            self.middleVideoView.hidden = NO;
            self.middleImageView.hidden = YES;
            
            self.middleVideoView.frame = self.topicItem.middleFrame;
            self.middleVideoView.topicItem = self.topicItem;
            break;
        }
        case JKTopicStyleVoice: {
            self.middleVoiceView.hidden = NO;
            self.middleVideoView.hidden = YES;
            self.middleImageView.hidden = YES;
            
            self.middleVoiceView.frame = self.topicItem.middleFrame;
            self.middleVoiceView.topicItem = self.topicItem;
            break;
        }
        case JKTopicStyleImage: {
            self.middleVoiceView.hidden = YES;
            self.middleVideoView.hidden = YES;
            self.middleImageView.hidden = NO;
            
            self.middleImageView.frame = self.topicItem.middleFrame;
            self.middleImageView.topicItem = self.topicItem;
            break;
        }
        case JKTopicStyleWord: {
            self.middleVoiceView.hidden = YES;
            self.middleVideoView.hidden = YES;
            self.middleImageView.hidden = YES;
            
            break;
        }
        default:
            break;
    }
    
}

/** 模型属性的setter方法 */
- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    _nameLabel.text = topicItem.name;
    _passtimeLabel.text = topicItem.passtime;
    _text_label.text = topicItem.text;
    
    [self setButton:_loveButton withNumber:topicItem.love];
    [self setButton:_hateButton withNumber:topicItem.hate];
    [self setButton:_repostButton withNumber:topicItem.repost];
    [self setButton:_commentButton withNumber:topicItem.comment];
    
    // 处理最热评论
    if (topicItem.top_cmt.count) {
        // 如果有最热评论
        _topCmtView.hidden = NO;
        NSString *cmtName = topicItem.top_cmt[0][@"user"][@"username"];
        NSString *cmtContent = topicItem.top_cmt[0][@"content"];
        if (cmtContent.length == 0) {
            // 如果评论内容是声音，在外面就提示【声音评论】
            cmtContent = @"【声音评论】";
        }
        _topCmtLabel.text = [NSString stringWithFormat:@"%@:%@", cmtName, cmtContent];
    } else {
        // 如果没有最热评论，隐藏控件
        _topCmtView.hidden = YES;
    }
}

/** 重写frame的setter方法，保证cell之间的间距 */
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= JKMargin;
    [super setFrame:frame];
}

/** 设置操作栏按钮的文字 */
- (void)setButton:(UIButton *)button withNumber:(NSInteger)num {
    if (num >= 10000) {
        NSString *floatStr = [NSString stringWithFormat:@"%.1f万", num / 10000.0];
        floatStr = [floatStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        [button setTitle:floatStr forState:UIControlStateNormal];
    } else if (num > 0) {
        [button setTitle:[NSString stringWithFormat:@"%ld", num] forState:UIControlStateNormal];
    }
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

@end

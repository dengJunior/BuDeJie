//
//  JKTopicCell.m
//  BuDeJie
//
//  Created by Joker on 16/7/18.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTopicCell.h"
#import "JKTopicItem.h"
#import "JKMiddleVoiceView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

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

@end

@implementation JKTopicCell

- (JKMiddleVoiceView *)middleVoiceView {
    if (!_middleVoiceView) {
        JKMiddleVoiceView *middleVoiceView = [JKMiddleVoiceView voiceView];
        [self.contentView addSubview:middleVoiceView];
        _middleVoiceView = middleVoiceView;
    }
    return _middleVoiceView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.middleVoiceView.frame = self.topicItem.middleFrame;
    self.middleVoiceView.topicItem = self.topicItem;
}

- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    _nameLabel.text = topicItem.name;
    _passtimeLabel.text = topicItem.passtime;
    _text_label.text = topicItem.text;
    
    [self setButton:_loveButton num:topicItem.love];
    [self setButton:_hateButton num:topicItem.hate];
    [self setButton:_repostButton num:topicItem.repost];
    [self setButton:_commentButton num:topicItem.comment];
    
    if (topicItem.top_cmt.count) {
        _topCmtView.hidden = NO;
        NSString *cmtName = topicItem.top_cmt[0][@"user"][@"username"];
        NSString *cmtContent = topicItem.top_cmt[0][@"content"];
        if (cmtContent.length == 0) {
            cmtContent = @"【声音评论】";
        }
        _topCmtLabel.text = [NSString stringWithFormat:@"%@:%@", cmtName, cmtContent];
    } else {
        _topCmtView.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= JKMargin;
    [super setFrame:frame];
}

- (void)setButton:(UIButton *)button num:(NSInteger)num {
    if (num >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", num / 10000.0] forState:UIControlStateNormal];
    } else if (num > 0) {
        [button setTitle:[NSString stringWithFormat:@"%ld", num] forState:UIControlStateNormal];
    }
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
}

@end

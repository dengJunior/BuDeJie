//
//  JKTopicCell.m
//  BuDeJie
//
//  Created by Joker on 16/7/18.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTopicCell.h"
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


@end

@implementation JKTopicCell

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

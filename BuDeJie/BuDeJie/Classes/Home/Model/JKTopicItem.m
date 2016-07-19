//
//  JKTopicItem.m
//  BuDeJie
//
//  Created by Joker on 16/7/16.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTopicItem.h"

@implementation JKTopicItem

/** 计算cell的高度 */
- (CGFloat)cellHeight {
    // 如果cell高度已经算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 间距 + 头像高度 + 间距
    _cellHeight += 35 + 2 *JKMargin;
    // 文字最大尺寸
    CGSize maxTextSize = CGSizeMake(screenW - 2 * JKMargin, MAXFLOAT);
    // 文字的高度 + 间距
    _cellHeight += [self.text boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + JKMargin;
    
    CGFloat middleW = screenW - 2 *JKMargin;
    CGFloat middleH = middleW / self.width * self.height;
    _middleFrame = CGRectMake(JKMargin, _cellHeight, middleW, middleH);
    
    // 图片高度 + 间距
    _cellHeight += middleH + JKMargin;
    
    // 热门评论
    if (self.top_cmt.count) {
        NSString *cmtName = self.top_cmt[0][@"user"][@"username"];
        NSString *cmtContent = self.top_cmt[0][@"content"];
        if (cmtContent.length == 0) {
            cmtContent = @"【声音评论】";
        }
        NSString *topCmt = [NSString stringWithFormat:@"%@:%@", cmtName, cmtContent];
        
        // “最热评论”标题高度
        _cellHeight += [cmtName boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        // 评论的内容
        _cellHeight += [topCmt boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    }
    
    // 底部操作栏 + 流出的cell分割线宽度（间距）
    _cellHeight += 35 + JKMargin;
    
    return _cellHeight;
}

@end

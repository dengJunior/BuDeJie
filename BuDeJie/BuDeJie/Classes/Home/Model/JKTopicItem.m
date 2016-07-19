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
    
    // 底部操作栏 + 流出的cell分割线宽度（间距）
    _cellHeight += 35 + JKMargin;
    
    return _cellHeight;
}

@end

//
//  JKTopicItem.h
//  BuDeJie
//
//  Created by Joker on 16/7/16.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKTopicItem : NSObject

// profile_image, name, passtime, text, love, hate, comment, repost
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 用户昵称 */
@property (nonatomic, copy) NSString *name;
/** 通过审核的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 状态的文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶数 */
@property (nonatomic, assign) NSInteger love;
/** 踩数 */
@property (nonatomic, assign) NSInteger hate;
/** 评论数 */
@property (nonatomic, assign) NSInteger comment;
/** 转发数 */
@property (nonatomic, assign) NSInteger repost;


@end

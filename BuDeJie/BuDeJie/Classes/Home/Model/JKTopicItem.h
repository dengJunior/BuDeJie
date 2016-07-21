//
//  JKTopicItem.h
//  BuDeJie
//
//  Created by Joker on 16/7/16.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 状态的类型 */
typedef NS_ENUM(NSUInteger, JKTopicStyle) {
    /** 全部 */
    JKTopicStyleAll = 1,            
    /** 图片 */
    JKTopicStylePicture = 10,
    /** 段子 */
    JKTopicStyleWord = 29,
    /** 音频 */
    JKTopicStyleVoice = 31,
    /** 视频 */
    JKTopicStyleVideo = 41
};

@interface JKTopicItem : NSObject

/** cell的类型 */
@property (nonatomic, assign) JKTopicStyle type;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

//--------------- cell顶部控件的数据 -------------------
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 用户昵称 */
@property (nonatomic, copy) NSString *name;
/** 通过审核的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 状态的文字内容 */
@property (nonatomic, copy) NSString *text;

//--------------- cell底部操作栏数据 -------------------
/** 顶数 */
@property (nonatomic, assign) NSInteger love;
/** 踩数 */
@property (nonatomic, assign) NSInteger hate;
/** 评论数 */
@property (nonatomic, assign) NSInteger comment;
/** 转发数 */
@property (nonatomic, assign) NSInteger repost;

//--------------- cell的图片 -------------------
/** 是否是gif动画 */
@property (nonatomic, assign) BOOL is_gif;
/** cell中显示的图片的宽 */
@property (nonatomic, assign) NSInteger width;
/** cell中显示的图片的高 */
@property (nonatomic, assign) NSInteger height;
/** 小图地址 */
@property (nonatomic, strong) NSString *image0;
/** 大图地址 */
@property (nonatomic, strong) NSString *image1;
/** 中图地址 */
@property (nonatomic, strong) NSString *image2;

//--------------- 声音类cell的图片内容 -------------------
// voicetime，playcount，image0，image1，image2
/** 声音时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

//--------------- 视频类cell的图片内容 -------------------
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频加载时候的静态显示的图片 */
@property (nonatomic, copy) NSString *cdn_img;


//--------------- 非获取数据 -------------------
/** 显示本模型数据的cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** cell中间图片的frame */
@property (nonatomic, assign) CGRect middleFrame;
/** 是否超长图片 */
@property (nonatomic, assign, getter=isLongImage) BOOL longImage;

@end

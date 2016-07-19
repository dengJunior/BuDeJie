//
//  JKMiddleVoiceView.h
//  BuDeJie
//
//  Created by Joker on 16/7/19.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>   
@class JKTopicItem;

@interface JKMiddleVoiceView : UIView

/** 模型属性 */
@property (nonatomic, strong) JKTopicItem *topicItem;

+ (instancetype)voiceView;

@end

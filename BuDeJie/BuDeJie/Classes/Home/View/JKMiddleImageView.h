//
//  JKMiddleImageView.h
//  BuDeJie
//
//  Created by Joker on 16/7/20.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKTopicItem;

@interface JKMiddleImageView : UIView

/** 模型属性 */
@property (nonatomic, strong) JKTopicItem *topicItem;

+ (instancetype)imageView;

@end

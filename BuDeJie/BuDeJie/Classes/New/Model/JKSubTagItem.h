//
//  JKSubTagItem.h
//  BuDeJie
//
//  Created by Joker on 16/7/12.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "image_list" = "http://img.spriteapp.cn/ugc/2016/03/10/092924_69853.jpg";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 201553;
 "theme_id" = 3096;
 "theme_name" = "百思红人";
 */

@interface JKSubTagItem : NSObject

@property (nonatomic, copy) NSString *image_list;
@property (nonatomic, copy) NSString *theme_name;
@property (nonatomic, copy) NSString *sub_number;

@end

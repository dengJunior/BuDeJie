//
//  JKFastLoginView.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKFastLoginView.h"

@implementation JKFastLoginView

+ (instancetype)fastLoginView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:kNilOptions][0];
}

@end

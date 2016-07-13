//
//  JKSquareCell.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKSquareCell.h"
#import "JKSquareItem.h"
#import <UIImageView+WebCache.h>

@interface JKSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation JKSquareCell

- (void)setSquareItem:(JKSquareItem *)squareItem {
    
    _squareItem = squareItem;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]];
    _nameLabel.text = squareItem.name;
}



@end

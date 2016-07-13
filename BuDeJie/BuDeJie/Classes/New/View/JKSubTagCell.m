//
//  JKSubTagCell.m
//  BuDeJie
//
//  Created by Joker on 16/7/12.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKSubTagCell.h"
#import <UIImageView+WebCache.h>

@interface JKSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation JKSubTagCell

- (void)setSubTagItem:(JKSubTagItem *)subTagItem {
    
    _subTagItem = subTagItem;
    
    _titleLabel.text = subTagItem.theme_name;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:kNilOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 如果URL没有图片，就用占位图片来裁剪
        if (image == nil) image = [UIImage imageNamed:@"defaultUserIcon"];
        // 用上下文裁剪方式设置图片圆角
        _iconImageView.image = [UIImage circleImageWithOriginalImage:image];
        
    }];
    
    NSString *str = [NSString stringWithFormat:@"%@人已定阅", subTagItem.sub_number];
    NSInteger num = str.integerValue;
    
    if (num >= 10000) {
        CGFloat numF = num / 10000.0;
        str = [NSString stringWithFormat:@"%.1f万人已定阅", numF];
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numberLabel.text = str;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
    // 每个cell的高度-2，但是每个cell的x,y都是算好的，不会因前一个高度-2就贴上去， \
       所以cell之间会留出2的空隙，露出cell后面的视图
    frame.size.height -= 2;
    [super setFrame:frame];
}

- (IBAction)subscribeBtnClick {
}

@end

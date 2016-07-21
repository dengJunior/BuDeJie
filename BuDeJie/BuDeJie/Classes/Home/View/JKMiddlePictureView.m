//
//  JKMiddlePictureView.m
//  BuDeJie
//
//  Created by Joker on 16/7/20.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMiddlePictureView.h"
#import "JKTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <AFNetworkReachabilityManager.h>
#import "JKBigPictureViewController.h"

@interface JKMiddlePictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation JKMiddlePictureView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [_imageView addGestureRecognizer:tap];
}

+ (instancetype)pictureView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:kNilOptions][0];
}

- (void)setTopicItem:(JKTopicItem *)topicItem {
    _topicItem = topicItem;
    
    // 设置显示的图片
    [_imageView jk_setImageWithOriginalImageURL:topicItem.image1 thumbnailImageURL:topicItem.image0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 不是长图
        if (!topicItem.isLongImage) return;
        // gif图
        if (topicItem.is_gif) return;
        
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(topicItem.middleFrame.size, NO, 0);
        // 图片宽高
        CGFloat width = topicItem.middleFrame.size.width;
        CGFloat height = width / topicItem.width * topicItem.height;
        // 绘图
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得上下文中的图片
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    }];
    
    // 是否gif
    if (topicItem.is_gif) {
        self.gifImageView.hidden = NO;
    } else {
        self.gifImageView.hidden = YES;
    }
    
    // 长图按钮显隐
    _seeBigButton.hidden = !topicItem.isLongImage;
    
}

#pragma mark -
#pragma mark 事件处理
- (void)seeBigPicture {
    JKBigPictureViewController *bigPictureVc = [[JKBigPictureViewController alloc] init];
    bigPictureVc.topicItem = self.topicItem;
    [self.window.rootViewController presentViewController:bigPictureVc animated:YES completion:nil];
}

@end

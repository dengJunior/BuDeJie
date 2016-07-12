//
//  JKAdVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKAdVC.h"
#import "JKTabBarC.h"

@interface JKAdVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation JKAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLaunchImage];
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupLaunchImage {
    
    UIImage *image = nil;
    // 屏幕适配，不同屏幕显示不同大小的启动图片
    if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    self.imageView.image = image;
}

- (IBAction)skipBtnClick:(UIButton *)sender {
    
}



@end

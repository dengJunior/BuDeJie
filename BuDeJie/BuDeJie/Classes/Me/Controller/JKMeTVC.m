//
//  JKMeTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMeTVC.h"
#import "JKSettingTVC.h"

@implementation JKMeTVC

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self setupNavigationItems];
}


- (void)setupNavigationItems {
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *settingBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-sun-icon"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingBar, nightBar];
    
}

- (void)setting {
    JKSettingTVC *settingTvc = [[JKSettingTVC alloc] init];
    [self.navigationController pushViewController:settingTvc animated:YES];
}

- (void)night:(UIButton *)btn {
    btn.selected = !btn.selected;
}

@end

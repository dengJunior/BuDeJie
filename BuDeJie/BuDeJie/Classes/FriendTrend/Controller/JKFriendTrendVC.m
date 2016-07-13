//
//  JKFriendTrendVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKFriendTrendVC.h"
#import "JKLoginVC.h"

@implementation JKFriendTrendVC

- (void)viewDidLoad {
    
    [self setupNavigationItems];
}

- (void)setupNavigationItems {
    
    self.navigationItem.title = @"我的关注";
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

/** 点击左上角按钮 */
- (void)friendsRecomment {
    
}

/** 点击登录按钮 */
- (IBAction)loginBtnClick {
    
    JKLoginVC *loginVc = [[JKLoginVC alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}


@end

//
//  JKFriendTrendVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKFriendTrendVC.h"

@implementation JKFriendTrendVC

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self setupNavigationItems];
}

- (void)setupNavigationItems {
    
    self.navigationItem.title = @"我的关注";
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

- (void)friendsRecomment {
    
}

@end

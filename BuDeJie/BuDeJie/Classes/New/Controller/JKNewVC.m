//
//  JKNewVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKNewVC.h"
#import "JKSubTagTVC.h"

@implementation JKNewVC

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setupNavigationItems];
}

- (void)setupNavigationItems {
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(mainTagSub)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

- (void)mainTagSub {
    
    JKSubTagTVC *subTagTvc = [[JKSubTagTVC alloc] init];
    
    // 注意push出订阅页面控制器后应该将地步tabBar隐藏，写到navigationController中
    [self.navigationController pushViewController:subTagTvc animated:YES];
}

@end

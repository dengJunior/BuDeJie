//
//  JKNewVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKNewVC.h"

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
    
}

@end

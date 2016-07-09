//
//  JKHomeVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKHomeVC.h"

@implementation JKHomeVC

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupNavigationItems];
}

- (void)setupNavigationItems {
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_iconN"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandomN"] highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = rightBar;
}


- (void)game {
    
}

- (void)random {
    
}

@end

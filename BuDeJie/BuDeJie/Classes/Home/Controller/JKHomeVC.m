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
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_iconN"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    if (self.childViewControllers.count > 0) {
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        [btn setTitle:@"返回" forState:UIControlStateNormal];
//        [btn sizeToFit];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}

- (void)game {
    
}

@end

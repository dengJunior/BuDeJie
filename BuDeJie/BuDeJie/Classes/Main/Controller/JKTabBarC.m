//
//  JKTabBarC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTabBarC.h"
#import "JKHomeVC.h"
#import "JKNewVC.h"
#import "JKPublishVC.h"
#import "JKFriendTrendVC.h"
#import "JKMeTVC.h"
#import "JKNavigationController.h"

#import "JKTabBar.h"

@implementation JKTabBarC

#pragma mark -
#pragma mark 初始化子控制器
- (void)setupChildControllors {
    
    // 添加 首页页面 控制器
    JKHomeVC *homeVC = [[JKHomeVC alloc] init];
    JKNavigationController *homeNvc = [[JKNavigationController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:homeNvc];
    
    // 添加 新帖页面 控制器
    JKNewVC *newVC = [[JKNewVC alloc] init];
    JKNavigationController *newNvc = [[JKNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNvc];
    
    // 添加 发布页面 控制器
//    JKPublishVC *publishVc = [[JKPublishVC alloc] init];
//    [self addChildViewController:publishVc];
    
    // 添加 关注页面 控制器
    JKFriendTrendVC *friendTrendVC = [[JKFriendTrendVC alloc] init];
    JKNavigationController *friendTrendNvc = [[JKNavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:friendTrendNvc];
    
    // 添加 我页面 控制器
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:NSStringFromClass([JKMeTVC class]) bundle:nil];
    JKMeTVC *meTvc = [meStoryboard instantiateInitialViewController];
    JKNavigationController *meNvc = [[JKNavigationController alloc] initWithRootViewController:meTvc];
    [self addChildViewController:meNvc];
}

- (void)setupTabBarItems {
    
    // 设置tabBar上的 首页 按钮
    JKHomeVC *homeVC = self.childViewControllers[0];
    homeVC.tabBarItem.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBar上的 新帖 按钮
    JKNewVC *newVC = self.childViewControllers[1];
    newVC.tabBarItem.title = @"新帖";
    newVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    /*
    // 设置tabBar上的 发布 按钮
    JKPublishVC *publishVC = self.childViewControllers[2];
    publishVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    publishVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    // tabBarItem的按钮只有两种状态 -> 普通和选中，但是这里我们需要一个高亮状态 
    // 用系统的tabBarItem不能满足要求
    */
    
    // 设置tabBar上的 关注 按钮
    JKFriendTrendVC *friendTrendVC = self.childViewControllers[2];
    friendTrendVC.tabBarItem.title = @"关注";
    friendTrendVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendTrendVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBar上的 我 按钮
    JKMeTVC *meVC = self.childViewControllers[3];
    meVC.tabBarItem.title = @"我";
    meVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
}

#pragma mark -
#pragma mark 生命周期
+ (void)load {
    // 设置tabBar上按钮的文字格式
    // 普通
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // 选中
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置属性的全局效果
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [self setupChildControllors];
    
    [self setupTabBarItems];
    // 将tabBarController的tabBar替换成我自定义的样式
    JKTabBar *tabBar = [[JKTabBar alloc] init];
    // tabBar是只读属性，所以要用 KVC 修改
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}



@end

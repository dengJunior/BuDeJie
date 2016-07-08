//
//  JKTabBarC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKTabBarC.h"
#import "JKHomeNVC.h"
#import "JKNewNVC.h"
#import "JKPublishVC.h"
#import "JKFriendTrendNVC.h"
#import "JKMeNVC.h"
#import "JKTabBar.h"

@implementation JKTabBarC

#pragma mark -
#pragma mark 初始化子控制器
- (void)setupChildControllors {
    
    // 添加 首页页面 控制器
    JKHomeNVC *homeNvc = [[JKHomeNVC alloc] init];
    [self addChildViewController:homeNvc];
    
    // 添加 新帖页面 控制器
    JKNewNVC *newNvc = [[JKNewNVC alloc] init];
    [self addChildViewController:newNvc];
    
    // 添加 发布页面 控制器
    JKPublishVC *publishVc = [[JKPublishVC alloc] init];
    [self addChildViewController:publishVc];
    
    // 添加 关注页面 控制器
    JKFriendTrendNVC *friendTrendNvc = [[JKFriendTrendNVC alloc] init];
    [self addChildViewController:friendTrendNvc];
    
    // 添加 我页面 控制器
    JKMeNVC *meNvc = [[JKMeNVC alloc] init];
    [self addChildViewController:meNvc];
}

- (void)setupTabBarItems {
    
    // 设置tabBar上的 首页 按钮
    JKHomeNVC *homeNvc = self.childViewControllers[0];
    homeNvc.tabBarItem.title = @"首页";
    homeNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    homeNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBar上的 新帖 按钮
    JKNewNVC *newNvc = self.childViewControllers[1];
    newNvc.tabBarItem.title = @"新帖";
    newNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newNvc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    /*
    // 设置tabBar上的 发布 按钮
    JKPublishVC *publishNvc = self.childViewControllers[2];
    publishNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    publishNvc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    // tabBarItem的按钮只有两种状态 -> 普通和选中，但是这里我们需要一个高亮状态 
    // 用系统的tabBarItem不能满足要求
    */
    
    // 设置tabBar上的 关注 按钮
    JKFriendTrendNVC *friendTrendNvc = self.childViewControllers[2];
    friendTrendNvc.tabBarItem.title = @"关注";
    friendTrendNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendTrendNvc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBar上的 我 按钮
    JKMeNVC *meNvc = self.childViewControllers[3];
    meNvc.tabBarItem.title = @"我";
    meNvc.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meNvc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon" WithRendingMode:UIImageRenderingModeAlwaysOriginal];
    
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

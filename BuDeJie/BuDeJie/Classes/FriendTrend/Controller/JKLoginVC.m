//
//  JKLoginVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKLoginVC.h"
#import "JKLoginRegisterView.h"

@interface JKLoginVC ()

@property (weak, nonatomic)  UIView *centerView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation JKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCenterView];
    [self setupBottomView];
}

/** 设置中间登录视图 */
- (void)setupCenterView {
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, screenW * 2, 300)];
    [self.view addSubview:centerView];
    _centerView = centerView;
    // 创建登录视图
    JKLoginRegisterView *loginView = [JKLoginRegisterView loginView];
    // 设置登录视图的frame
    loginView.frame = CGRectMake(0, 0, screenW, _centerView.height);
    [centerView addSubview:loginView];
    
    // 创建注册视图
    JKLoginRegisterView *registerView = [JKLoginRegisterView registerView];
    // 设置注册视图的frame
    registerView.frame = CGRectMake(screenW, 0, screenW, _centerView.height);
    [centerView addSubview:registerView];
}

/** 设置底部快速登录视图 */
- (void)setupBottomView {
    
}

/** 点击关闭按钮时 */
- (IBAction)closeBtnClick:(UIButton *)sender {
    // 将本控制器dismiss掉
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 点击注册按钮时 */
- (IBAction)registerBtnClick:(UIButton *)sender {
    // 切换按钮选中状态
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.2 animations:^{
        // 根据按钮选中状态切换显示在屏幕上的视图
        _centerView.x = sender.selected ? -screenW : 0;
    }];
    
}


@end

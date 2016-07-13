//
//  JKNavigationController.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKNavigationController.h"

@interface JKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JKNavigationController

+ (void)load {
    // 拿到当前类下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // 设置导航条字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = attr;
    
    // 设置导航栏背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    
    // 定义一个pan手势，调用系统执行边缘返回的对象去执行系统的返回任务
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    // 给pan手势设置代理，可以决定什么时候接受手势，避免假死
    pan.delegate = self;
    // 添加手势
    [self.view addGestureRecognizer:pan];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSLog(@"%@", self.interactivePopGestureRecognizer);
    // 设置返回按钮要在下一个控制器push出来之前
    if (self.childViewControllers.count > 0) {
        
        // 每次push出一个新控制器，都应该将底部的tabBar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 如果当前控制器不是根控制器时，统一自定义设置导航栏左边的返回按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置返回按钮图片
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        // 设置文字，及字体颜色
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        // 微调按钮的位置
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        // 给返回按钮添加事件
        [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        // 按钮根据内容自适应大小
        [btn sizeToFit];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    // 系统自带一个边缘滑动返回手势，但是如果自定义返回按钮，这个手势就会失效
    // 重新设置这个手势的代理对象为本控制器，更改接收手势的判断逻辑，让系统的边缘滑动返回手势继续工作（取巧）
//    self.interactivePopGestureRecognizer.delegate = self; 
    // push出下一个控制器
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 如果当前控制器是根控制器，则不接收手势，防止假死
    return self.childViewControllers.count > 1;
}

- (void)goBack {
    [self popViewControllerAnimated:YES];
}

@end

//
//  JKHomeVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKHomeVC.h"

#import "JKAllTVC.h"
#import "JKVideoTVC.h"
#import "JKVoiceTVC.h"
#import "JKImageTVC.h"
#import "JKWordTVC.h"

@interface JKHomeVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) UIButton *previousSelectedButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIView *underLineView;
@property (nonatomic, assign) CGFloat buttonW;

@end

@implementation JKHomeVC

#pragma mark -
#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    self.titles = titles;
    
    // 取消自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigationItems];
    
    [self setupChildVCs];
    
    [self setupChildViews];
}

#pragma mark -
#pragma mark 初始化设置
/** 初始化导航栏 */
- (void)setupNavigationItems {
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *leftBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_iconN"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandomN"] highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

/** 初始化子控制器 */
- (void)setupChildVCs {
    
    [self addChildViewController:[[JKAllTVC alloc] init]];
    [self addChildViewController:[[JKVideoTVC alloc] init]];
    [self addChildViewController:[[JKVoiceTVC alloc] init]];
    [self addChildViewController:[[JKImageTVC alloc] init]];
    [self addChildViewController:[[JKWordTVC alloc] init]];
    
}

/** 初始化子控件 */
- (void)setupChildViews {
    // 添加scrollView
    [self setupScrollView];
    // 添加标题栏
    [self setupTitlesView];
#warning 刚开启程序的时候下划线不出现
    [self titleButtonClick:self.titlesView.subviews[0]];
}
/** 初始化scrollView */
- (void)setupScrollView {
    // 子控制器个数
    NSInteger count = self.titles.count;
    // 初始化一个屏幕大小的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置代理
    scrollView.delegate = self;
    // 背景色
    scrollView.backgroundColor = JKGlobeBackgroundColor;
    // 设置内容尺寸
    scrollView.contentSize = CGSizeMake(count * screenW, 0);
    // 开启分页
    scrollView.pagingEnabled = YES;
    // 隐藏scrollView的滑动指示器
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    // 添加
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的View
    for (NSInteger i = 0; i < count; i++) {
        // 获取每个子控制器的View
        UIView *tableView = self.childViewControllers[i].view;
        
        // 注意：一定要将y设为0，因为默认会有一个20的向下偏移
        tableView.frame = CGRectMake(i * screenW, 0, screenW, screenH);
        [scrollView addSubview:tableView];
    }
}

/** 初始化标题栏 */
- (void)setupTitlesView {
    
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, navMaxY, screenW, titleHeight)];
    // 标题栏颜色
    titlesView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题个数
    NSInteger count = self.titles.count;
    // 所有标题按钮平分屏宽
    CGFloat buttonW = screenW / count;
    self.buttonW = buttonW;
    
    // 添加标题按钮
    for (NSInteger i = 0; i < count; i++) {
        // 创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置按钮文字
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        // 给按钮添加点击事件
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮颜色
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        // 添加按钮
        button.frame = CGRectMake(buttonW * i, 0, buttonW, titleHeight);
        [titlesView addSubview:button];
    }
    
    // 添加下划线
    UIView *underLineView = [[UIView alloc] init];
    underLineView.height = 2;
    underLineView.y = titleHeight - underLineView.height;
    underLineView.backgroundColor = [UIColor redColor];
    [titlesView addSubview:underLineView];
    self.underLineView = underLineView;
}

#pragma mark -
#pragma mark 事件处理
/** 点击标题栏按钮 */
- (void)titleButtonClick:(UIButton *)button {
    // 取消上个按钮的选中状态
    self.previousSelectedButton.selected = NO;
    // 设置当前按钮的选中状态
    button.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        // 设置标题栏的下划线
        self.underLineView.width = button.titleLabel.width;
        self.underLineView.centerX = button.centerX;
        
        // 计算当前按钮的index
        NSInteger index = [self.titlesView.subviews indexOfObject:button];
        // 滑动tableView
        self.scrollView.contentOffset = CGPointMake(index * screenW, self.scrollView.contentOffset.y);
    }];
    // 让当前按钮成为上一个选中按钮
    self.previousSelectedButton = button;
}

/** 点击游戏按钮 */
- (void)game {
    
}

/** 点击随机按钮 */
- (void)random {
    
}

#pragma mark -
#pragma mark scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / screenW;
    [self titleButtonClick:self.titlesView.subviews[index]];
}

@end

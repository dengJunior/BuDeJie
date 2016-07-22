//
//  JKHomeVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKHomeVC.h"
#import "JKTitleButton.h"

#import "JKTopicAllViewController.h"
#import "JKTopicVideoViewController.h"
#import "JKTopicVoiceViewController.h"
#import "JKTopicPictureViewController.h"
#import "JKTopicWordViewController.h"

@interface JKHomeVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIView *underLineView;

@property (nonatomic, weak) JKTitleButton *previousSelectedButton;
@property (nonatomic, weak) UITableView *previousShowedView;

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
    
    [self addChildViewController:[[JKTopicAllViewController alloc] init]];
    [self addChildViewController:[[JKTopicVideoViewController alloc] init]];
    [self addChildViewController:[[JKTopicVoiceViewController alloc] init]];
    [self addChildViewController:[[JKTopicPictureViewController alloc] init]];
    [self addChildViewController:[[JKTopicWordViewController alloc] init]];
}

/** 初始化子控件 */
- (void)setupChildViews {
    // 添加scrollView
    [self setupScrollView];
    // 添加标题栏
    [self setupTitlesView];
}

/** 初始化scrollView */
- (void)setupScrollView {
    // 子控制器个数
    NSInteger count = self.titles.count;
    // 初始化一个屏幕大小的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 关掉scrollView的返回顶部
    scrollView.scrollsToTop = NO;
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
    
    // 加载第一个tableView
    [self loadChildTableViewAtIndex:0];
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
    
    // 添加标题按钮
    for (NSInteger i = 0; i < count; i++) {
        // 创建按钮
        JKTitleButton *button = [[JKTitleButton alloc] init];
        // 设置按钮文字
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        // 给按钮添加点击事件
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    // 初始化时第一个按钮为选中状态，下划线出现在第一个按钮下面
    JKTitleButton *firstButton = titlesView.subviews[0];
    firstButton.selected = YES;
    self.previousSelectedButton = firstButton;
    [firstButton.titleLabel sizeToFit];
    underLineView.width = firstButton.titleLabel.width +10;
    underLineView.centerX = firstButton.centerX;
}

/** 加载tableView(实现视图的懒加载) */
- (void)loadChildTableViewAtIndex:(NSInteger)index {
    
    // 获取每个子控制器的tableView
    UITableView *tableView = (UITableView *)self.childViewControllers[index].view;
    
    // 保证当前只有一个tableView的scrollToTop为YES，确保点击通知栏返回顶部功能可用
    self.previousShowedView.scrollsToTop = NO;
    tableView.scrollsToTop = YES;
    self.previousShowedView = tableView;
    
    if (tableView.superview) return;
    // 注意：一定要将y设为0，因为默认会有一个20的向下偏移
    tableView.frame = CGRectMake(index * screenW, 0, screenW, screenH);
    [self.scrollView addSubview:tableView];
}

#pragma mark -
#pragma mark 事件处理
/** 点击标题栏按钮 */
- (void)titleButtonClick:(JKTitleButton *)button {
    // 取消上个按钮的选中状态
    self.previousSelectedButton.selected = NO;
    // 设置当前按钮的选中状态
    button.selected = YES;
    // 让当前按钮成为上一个选中按钮
    self.previousSelectedButton = button;
    
    // 计算当前按钮的index
    NSInteger index = [self.titlesView.subviews indexOfObject:button];
    // 加载tableView
    [self loadChildTableViewAtIndex:index];
    
    [UIView animateWithDuration:0.25 animations:^{
        // 设置标题栏的下划线
        self.underLineView.width = button.titleLabel.width +10;
        self.underLineView.centerX = button.centerX;
        // 滑动tableView
        self.scrollView.contentOffset = CGPointMake(index * screenW, self.scrollView.contentOffset.y);
    }];
}

/** 点击游戏按钮 */
- (void)game {
    
}

/** 点击随机按钮 */
- (void)random {
    
}

#pragma mark -
#pragma mark scrollView delegate
/** scrollView停止时 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算此时scrollView的X偏移
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算此时页面索引
    NSInteger index = offsetX / screenW;
    // 主动点击相应的标题按钮
    [self titleButtonClick:self.titlesView.subviews[index]];
}

@end

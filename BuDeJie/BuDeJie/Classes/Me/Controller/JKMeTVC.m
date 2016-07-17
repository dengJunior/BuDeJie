//
//  JKMeTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/7.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKMeTVC.h"
#import "JKSettingTVC.h"
#import "JKSquareItem.h"
#import "JKSquareCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import <SafariServices/SafariServices.h>


static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (screenW - (margin * (cols - 1))) / cols

static NSString *squareCellID = @"squareCellID";

@interface JKMeTVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *squareItems;

@end

@implementation JKMeTVC

#pragma mark -
#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JKGlobeBackgroundColor;
    
    // 调整模块间的高度
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self setupNavigationItems];
    
    [self setupFooterView];
    
    [self loadData];
}

#pragma mark -
#pragma mark 初始化
/** 初始化导航条 */
- (void)setupNavigationItems {
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *settingBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightBar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-sun-icon"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingBar, nightBar];
    
}

/** 初始化尾部collection控件 */
- (void)setupFooterView {
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    // 设置frame
    CGRect frame = CGRectMake(0, 0, screenW, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView = collectionView;
    
    // 设置返回顶部
    collectionView.scrollsToTop = NO;
    
    // 设置代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 背景色
    collectionView.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"JKSquareCell" bundle:nil] forCellWithReuseIdentifier:squareCellID];
    
    // 设为tableView的尾部控件
    self.tableView.tableFooterView = collectionView;
    
}

#pragma mark -
#pragma mark 网络请求相关操作
/** 加载数据 */
- (void)loadData {
    // 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        // 将响应回来的数据解析成模型数组
        NSMutableArray *squareItems = [JKSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        // 处理一下收到的模型数组，如果不是4整数倍个，则补齐
        self.squareItems = [self handleDataWithItems:squareItems];
        
        // 重新计算CollectionView的frame
        NSInteger rows = (squareItems.count - 1) / cols + 1;
        CGFloat height = itemWH * rows + margin * (rows - 1);
        // 重新设置一次尾部控件，保证tableView可以上下滑动（tableView的滑动范围根据内容确定）
        UICollectionView *collectionView = self.collectionView;
        collectionView.height = height;
        self.tableView.tableFooterView = collectionView;
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JKLog(@"%@", error)
    }];
}

/** 处理收到的模型，如果不是cols的整数倍数，则补齐 */
- (NSMutableArray *)handleDataWithItems:(NSMutableArray *)items {
    // 最后一行的剩余的个数
    NSInteger extra = items.count % cols;
    // 剩余0则直接返回
    if (extra == 0) return items;
    // 否则，缺几个补几个
    for (NSInteger i = 0; i < cols - extra; i++) {
        JKSquareItem *item = [[JKSquareItem alloc] init];
        [items addObject:item];
    }
    return items;
}

#pragma mark -
#pragma mark 事件处理

/** 点击设置按钮 */
- (void)setting {
    JKSettingTVC *settingTvc = [[JKSettingTVC alloc] init];
    [self.navigationController pushViewController:settingTvc animated:YES];
}
/** 点击夜晚按钮 */
- (void)night:(UIButton *)btn {
    btn.selected = !btn.selected;
}

#pragma mark -
#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:squareCellID forIndexPath:indexPath];
    
    cell.squareItem = self.squareItems[indexPath.item];
    
    return cell;
}

#pragma mark -
#pragma mark collectionView delegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKSquareItem *item = self.squareItems[indexPath.item];
    // 如果当前cell对应的“URL”不是网站就直接返回
    if (![item.url containsString:@"http"]) return;
    // 获取URL
    NSURL *url = [NSURL URLWithString:item.url];
    // 创建一个Safari控制器
    SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:url];
    // modal出Safari控制器
    [self presentViewController:safariController animated:YES completion:nil];
    
}


@end

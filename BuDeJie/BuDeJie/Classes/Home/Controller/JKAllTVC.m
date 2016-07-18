//
//  JKAllTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/14.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKAllTVC.h"
#import "JKTopicItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#import "JKTopicCell.h"

static NSString *const allCellID = @"allCellID";

@interface JKAllTVC ()

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *topicItems;
/** AFN会话管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 是否正在加载新数据 */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
/** 是否正在加载更多数据 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
/** 加载更多数据时的参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上拉刷新label */
@property (nonatomic, weak) UILabel *footerLabel;
/** 下拉刷新label */
@property (nonatomic, weak) UILabel *headerLabel;

/** cell的类型 */
@property (nonatomic, assign) NSInteger type;

@end

@implementation JKAllTVC
#pragma mark -
#pragma mark 懒加载
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark -
#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 1;
//    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"JKTopicCell" bundle:nil] forCellReuseIdentifier:allCellID];
    
    self.tableView.contentInset = UIEdgeInsetsMake(titleMaxY, 0, tabBarHeight, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundColor = JKRandomColor;
    
    [self setupRefreshViews];
    
    [self headerBeginRefreshing];
}

#pragma mark -
#pragma mark 初始化
/** 初始化刷新控件 */
- (void)setupRefreshViews {
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, screenW, 40)];
    headerLabel.backgroundColor = [UIColor redColor];
    headerLabel.text = @"下拉刷新数据";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:headerLabel];
    self.headerLabel = headerLabel;
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉刷新数据";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = footerLabel;
    self.footerLabel = footerLabel;
}


#pragma mark -
#pragma mark 网络请求及数据处理
/** 加载更多数据（上拉刷新） */
- (void)loadMoreData {
//    [self.manager invalidateSessionCancelingTasks:YES];
//    self.manager = nil;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    
    [self.manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray *topicItems = [JKTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicItems addObjectsFromArray:topicItems];
        // 刷新
        [self.tableView reloadData];
        // 上拉刷新完成
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 上拉刷新完成
        [self footerEndRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候重试!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}
/** 加载新数据（下拉刷新） */
- (void)loadNewData {
//    [self.manager invalidateSessionCancelingTasks:YES];
    //    self.manager = nil;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    
    [self.manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 设置获取个多数据时的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray *topicItems = [JKTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 模型属性赋值
        _topicItems = topicItems;
        // 刷新
        [self.tableView reloadData];
        // 下拉刷新完成
        [self headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 下拉刷新完成
        [self headerEndRefreshing];
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候重试!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];

}
#pragma mark -
#pragma mark 处理数据刷新
/** 处理头部刷新逻辑 */
- (void)dealHeader {
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY <= -(titleMaxY + self.headerLabel.height)) {
        // headerLabel完全显示
        self.headerLabel.backgroundColor = [UIColor blueColor];
        self.headerLabel.text = @"松开刷新数据";
    } else {
        // headerLabel还没完全显示
        self.headerLabel.backgroundColor = [UIColor redColor];
        self.headerLabel.text = @"下拉刷新数据";
    }
}
/** 开始下拉刷新 */
- (void)headerBeginRefreshing {
    self.headerRefreshing = YES;
    self.headerLabel.text = @"正在刷新数据";
    self.headerLabel.backgroundColor = [UIColor purpleColor];
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = titleMaxY + self.headerLabel.height;
        self.tableView.contentInset = insets;
    }];
    [self loadNewData];
}
/** 下拉刷新结束 */
- (void)headerEndRefreshing {
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = titleMaxY;
        self.tableView.contentInset = insets;
    }];
    self.headerLabel.text = @"下拉刷新数据";
    self.headerLabel.backgroundColor = [UIColor redColor];
    self.headerRefreshing = NO;
}

/** 处理尾部刷新逻辑 */
- (void)dealFooter {
    if (!_topicItems.count) return;
    if (self.isFooterRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY >= self.tableView.contentSize.height + tabBarHeight - screenH) {
        
        [self footerBeginRefreshing];
    }
}
/** 开始上拉刷新 */
- (void)footerBeginRefreshing {
    self.footerLabel.text = @"正在加载更多数据";
    self.footerLabel.backgroundColor = [UIColor blueColor];
    self.footerRefreshing = YES;
    [self loadMoreData];
}
/** 上拉刷新结束 */
- (void)footerEndRefreshing {
    self.footerLabel.text = @"上拉刷新数据";
    self.footerLabel.backgroundColor = [UIColor redColor];
    self.footerRefreshing = NO;
}

#pragma mark -
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self dealHeader];
    [self dealFooter];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= -(titleMaxY + self.headerLabel.height)) {
        [self headerBeginRefreshing];
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.tableFooterView.hidden = !_topicItems.count;
    return _topicItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:allCellID];
    
    JKTopicItem *topicItem = self.topicItems[indexPath.row];
    
    cell.topicItem = topicItem;
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    return cell;
}

#pragma mark -
#pragma mark TableView delegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = 0;
    cellHeight += 55;
    
    JKTopicItem *topicItem = self.topicItems[indexPath.row];
    CGSize maxSize = CGSizeMake(screenW - 2 * JKMargin, MAXFLOAT);
    cellHeight += [topicItem.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    cellHeight += 35 + 2 *JKMargin;
    
    return cellHeight;
}


@end

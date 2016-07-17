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

static NSString *allCellID = @"allCellID";
@interface JKAllTVC ()

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *topicItems;
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

@end

@implementation JKAllTVC
#pragma mark -
#pragma mark 懒加载
//- (NSMutableArray *)topicItems {
//    if (!_topicItems) {
//        _topicItems = [NSMutableArray array];
//    }
//    return _topicItems;
//}

#pragma mark -
#pragma mark view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(titleMaxY, 0, tabBarHeight, 0);
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundColor = JKRandomColor;
    
    [self setupRefreshViews];
    
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
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    if (self.maxtime) {
        parameters[@"maxtime"] = self.maxtime;
    }
    
    [manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray *topicItems = [JKTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicItems addObjectsFromArray:topicItems];
        // 刷新
        [self.tableView reloadData];
        // 上拉刷新完成
        self.footerLabel.text = @"上拉刷新数据";
        self.footerLabel.backgroundColor = [UIColor redColor];
        self.footerRefreshing = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候重试!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        // 上拉刷新完成
        self.footerLabel.text = @"上拉刷新数据";
        self.footerLabel.backgroundColor = [UIColor redColor];
        self.footerRefreshing = NO;
    }];
}
/** 加载新数据（下拉刷新） */
- (void)loadNewData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    
    [manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 设置获取个多数据时的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSMutableArray *topicItems = [JKTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _topicItems = topicItems;
            // 刷新
            [self.tableView reloadData];
            JKFunc
            // 下拉刷新完成
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets insets = self.tableView.contentInset;
                insets.top = titleMaxY;
                self.tableView.contentInset = insets;
            }];
            self.headerLabel.text = @"下拉刷新数据";
            self.headerLabel.backgroundColor = [UIColor redColor];
            self.headerRefreshing = NO;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"加载失败,请稍候重试!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        // 下拉刷新完成
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets insets = self.tableView.contentInset;
            insets.top = titleMaxY;
            self.tableView.contentInset = insets;
        }];
        self.headerLabel.text = @"下拉刷新数据";
        self.headerLabel.backgroundColor = [UIColor redColor];
        self.headerRefreshing = NO;
    }];
}
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
- (void)dealFooter {
    if (self.isFooterRefreshing) return;
    if (self.topicItems.count == 0) return;
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY >= self.tableView.contentSize.height + tabBarHeight - screenH) {
        
        self.footerLabel.text = @"正在加载更多数据";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        self.footerRefreshing = YES;
        [self loadMoreData];
    }
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
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.tableFooterView.hidden = _topicItems.count == 0;
    return _topicItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:allCellID];
    }
    
    JKTopicItem *item = self.topicItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.text;
    
    return cell;
}




@end

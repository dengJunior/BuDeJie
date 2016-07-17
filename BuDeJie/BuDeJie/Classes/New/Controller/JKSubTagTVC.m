//
//  JKSubTagTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/12.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKSubTagTVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "JKSubTagCell.h"
#import "JKSubTagItem.h"

static NSString *subTagCellID = @"subTagCell";

@interface JKSubTagTVC ()

@property (nonatomic, strong) NSArray *subtags;

@end

@implementation JKSubTagTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = JKColorWith(215, 215, 215);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JKSubTagCell" bundle:nil] forCellReuseIdentifier:subTagCellID];
    
    [self loadData];
}

- (void)loadData {
    
    // 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    [manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *_Nullable responseObject) {
        
        // 讲返回的字典数组转成模型数组
        NSArray *subTags = [JKSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        self.subtags = subTags;
        
        // 刷新tableView数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JKLog(@"%@", error)
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subtags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JKSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:subTagCellID forIndexPath:indexPath];
    
    cell.subTagItem = self.subtags[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 + 2;
}

#pragma mark -
#pragma mark TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

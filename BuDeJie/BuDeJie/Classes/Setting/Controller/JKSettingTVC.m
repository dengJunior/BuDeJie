//
//  JKSettingTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKSettingTVC.h"

@implementation JKSettingTVC

#pragma mark -
#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *settingCellID = @"settingCellID";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCellID];
    
    cell.textLabel.text = @"清除缓存";
    return cell;
}

#pragma mark -
#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 清除缓存
    [self cleanCaches];
    
    // 改变cell的文字显示
    
    // 取消cell选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark 对缓存的操作
- (void)cleanCaches {
    // 计算缓存大小
    
    // 清除
    
}


@end

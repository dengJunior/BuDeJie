//
//  JKSettingTVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKSettingTVC.h"
#import <SDImageCache.h>

static NSString *settingCellID = @"settingCellID";

@implementation JKSettingTVC

#pragma mark -
#pragma mark view cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置本页标题
    self.title = @"设置";
    
    // 注册cell重用标识
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCellID];
}

#pragma mark -
#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // SDWebImage计算的缓存大小
    NSInteger sizeSD = [[SDImageCache sharedImageCache] getSize];
    JKLog(@"sizeSD--%ld", sizeSD)
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID forIndexPath:indexPath];
    
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
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 创建文件管理者对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 总大小
    NSInteger totalSize = 0;
    // 取缓存路径
    cachePath = [cachePath stringByAppendingString:@"/default"];
    // 遍历路径下所有文件计算大小
    for (NSString *subPath in [fileManager subpathsOfDirectoryAtPath:cachePath error:nil]) {
        // 拼接全路径
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        
        BOOL isDirectory; // 是否是文件夹
        BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory]; // 是否存在
        // 如果路径不存在，或路径是文件夹
        if (isExist == NO || isDirectory) continue;
        // 排除系统文件
        if ([fullPath containsString:@".DS_Store"]) continue;
        
        // 取文件属性
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullPath error:nil];
        
        // 文件大小
        NSNumber *size = (NSNumber *)attrs[NSFileSize];
        // 累加
        totalSize += size.integerValue;
    }
    JKLog(@"totalSize = %ld", totalSize)
//    NSDictionary *attr = [fileManager attributesOfItemAtPath:cachePath error:nil];
//    JKLog(@"attr---%@", attr)
    
    
    // 清除
    
}


@end

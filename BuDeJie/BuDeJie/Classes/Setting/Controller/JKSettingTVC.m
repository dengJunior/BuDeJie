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

@interface JKSettingTVC ()

@property (nonatomic, strong) NSString *defaultPath;

@end

@implementation JKSettingTVC

#pragma mark -
#pragma mark view cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置本页标题
    self.title = @"设置";
    
//    // 系统缓存路径
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    self.cachePath = cachePath;
    
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
    
    cell.textLabel.text = [self getCacheSizeStr];
    
    return cell;
}

#pragma mark -
#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 清除缓存
    [self cleanCaches];
    
    // 改变cell的文字显示
    [tableView reloadData];
    
    // 取消cell选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark 对缓存的操作
- (void)cleanCaches {
    // 清除
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 删掉default文件夹
    [fileManager removeItemAtPath:self.defaultPath error:nil];
}

/** 清除缓存cell的文字 */
- (NSString *)getCacheSizeStr {
    // 先拿到缓存大小
    NSInteger size = [self getCacheSize];
    
    CGFloat sizeF = 0.0;
    NSString *sizeStr = @"清除缓存";
    if (size >= 1000 * 1000) {
        sizeF = size * 0.001 * 0.001;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, sizeF];
    } else if (size >= 1000) {
        sizeF = size * 0.001;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeF];
    } else if (size > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%ldB)", sizeStr, size];
    } 
    
    sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    return sizeStr;
}

- (NSInteger)getCacheSize {
    // 系统缓存路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 系统缓存路径
    NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
    self.defaultPath = defaultPath;
    // 创建文件管理者对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 总大小
    NSInteger totalSize = 0;
    // 遍历路径下所有文件计算大小
    for (NSString *subPath in [fileManager subpathsOfDirectoryAtPath:defaultPath error:nil]) {
        // 拼接全路径
        NSString *fullPath = [defaultPath stringByAppendingPathComponent:subPath];
        
        BOOL isDirectory; // 是否是文件夹
        BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory]; // 是否存在
        // 如果路径不存在，或路径是文件夹，则不用计算
        if (isExist == NO || isDirectory) continue;
        // 如果路径下是系统文件，则不用计算
        if ([fullPath containsString:@".DS_Store"]) continue;
        
        // 取文件属性
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullPath error:nil];
        // 文件大小
        NSNumber *size = (NSNumber *)attrs[NSFileSize];
        // 累加
        totalSize += size.integerValue;
    }
    return totalSize;
}


@end

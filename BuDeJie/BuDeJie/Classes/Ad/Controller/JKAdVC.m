//
//  JKAdVC.m
//  BuDeJie
//
//  Created by Joker on 16/7/9.
//  Copyright © 2016年 Joker. All rights reserved.
//
/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

#import "JKAdVC.h"
#import "JKTabBarC.h"
#import "JKADItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#define JKCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface JKAdVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, strong) JKADItem *adItem;

@end

@implementation JKAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLaunchImage];
    
    [self loadData];
    
    // 设置定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupLaunchImage {
    
    UIImage *image = nil;
    // 屏幕适配，不同屏幕显示不同大小的启动图片
    if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    self.imageView.image = image;
}

/** 加载广告图片数据 */
- (void)loadData {
    // 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 把text/html设为可接受类型content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = JKCode2;
    
    [manager GET:JKRequestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        
        // 用模型保存返回的数据
        JKADItem *adItem = [JKADItem mj_objectWithKeyValues:responseObject[@"ad"][0]];
        self.adItem = adItem;
        
        // 根据比例缩放返回的图片，让其宽度为屏宽
        CGFloat h = screenW / adItem.w.floatValue * adItem.h.floatValue;
        CGRect frame = CGRectMake(0, 0, screenW, h);
        
        UIImageView *adImageView = [[UIImageView alloc] init];
        adImageView.frame = frame;
        adImageView.userInteractionEnabled = YES;
        
        // 设置一个tap手势添加给广告图片，点击是跳转到广告连接
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToAdUrl)];
        [adImageView addGestureRecognizer:tap];
        
        // 设置图片
        [adImageView sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
        
        // 添加控件
        [self.containerView addSubview:adImageView];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        JKLog(@"%@", error)
    }];
}

/** 跳过按钮点击时 */
- (IBAction)skipBtnClick:(UIButton *)sender {
    
    // 跳转到主页面
    JKTabBarC *tabBarC = [[JKTabBarC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarC;
    // 销毁定时器
    [self.timer invalidate];
}

/** 定时器执行的方法 */
- (void)timeChange {
    // 时间初始为3秒
    static NSInteger time = 3;
    
    time --;
    
    if (time == 0) {
        // 时间到后强制点击跳转按钮
        [self skipBtnClick:nil];
    }
    NSString *btnStr = [NSString stringWithFormat:@"跳过 (%ld)", time];
    // 修改跳过按钮的文字
    [self.skipBtn setTitle:btnStr forState:UIControlStateNormal];
}

/** 点击广告图片时，跳转 */
- (void)jumpToAdUrl {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    // 判断是否能跳转
    if ([app canOpenURL:url]) {
        // 能跳就跳
        [app openURL:url];
    }
}








@end

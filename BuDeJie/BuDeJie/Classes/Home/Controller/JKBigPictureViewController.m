//
//  JKBigPictureViewController.m
//  BuDeJie
//
//  Created by Joker on 16/7/21.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKBigPictureViewController.h"
#import "JKTopicItem.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface JKBigPictureViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/** 显示图片的imageView */
@property (nonatomic, weak) UIImageView *imageView;

/** 显示下载进度 */
@property (nonatomic, weak) UIProgressView *progressView;

@end

@implementation JKBigPictureViewController

- (UIProgressView *)progressView {
    if (!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.progressTintColor = [UIColor redColor];
        
        progressView.width = 200;
        progressView.center = self.view.center;
        [self.view addSubview:progressView];
        _progressView = progressView;
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    [self.scrollView addGestureRecognizer:tap];
    
    // 图片控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicItem.image1] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 显示进度条
        self.progressView.hidden = NO;
        // 设置进度
        _progressView.progress = 1.0 * receivedSize / expectedSize;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            // 图片下载完成，保存按钮可点
            self.saveButton.enabled = YES;
        }
        // 隐藏进度条
        self.progressView.hidden = YES;
    }];
    imageView.x = 0;
    imageView.width = screenW;
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat width = screenW;
    CGFloat height = screenW / self.topicItem.width * self.topicItem.height;
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.imageView.height = height;
    if (height > screenH) {
        self.imageView.y = 0;
    } else {
        self.imageView.centerY = screenH * 0.5;
    }
    
    // 缩放比例
    CGFloat scale = self.topicItem.width / screenW;
    if (scale > 1.0) {
        self.scrollView.maximumZoomScale = scale;
    } else {
        self.scrollView.minimumZoomScale = scale;
    }
    self.scrollView.delegate = self;
}

#pragma mark -
#pragma mark ScrollView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {

    [UIView animateWithDuration:0.25 animations:^{
        view.center = self.scrollView.center;
        if (view.height > screenH) {
            view.y = 0;
        }
        if (view.width > screenW) {
            view.x = 0;
        }
    }];
}

#pragma mark -
#pragma mark 事件处理
- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PHFetchResult *)createdAsset {
    // 1. 将照片保存进[Camera Roll]相册
    // 因为后面还要将这张图片“引用”到自定义相册中，所以要拿到[Camera Roll]中这张图片的Id
    __block NSString *createdAssetId = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // creationRequest...方法必须在performChanges...的block内调用
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    
    // 1.2 获取刚保存进[Camera Roll]的这张图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}

- (PHAssetCollection *) createdAssetCollection {
    // 2. 创建\获取 以应用名命名的自定义相册
    // 2.1 获取应用名
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 本应用的[自定义相册]
    PHAssetCollection *assetCollection = nil;
    
    // 2.2 获得所有的自定义相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 2.3 遍历->找到本应用的自定义相册
    for (PHAssetCollection *collection in result) {
        if ([collection.localizedTitle isEqualToString:title]) return collection;
    }
    
    // 2.4如果之前没有创建本应用的自定义相册
    // 自定义相册的Id
    __block NSString *assetCollectionId = nil;
    if (!assetCollection) {
        // 创建自定义相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            assetCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
        
        // 2.5 获取自定义相册
        assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionId] options:nil].firstObject;
    }
    return assetCollection;
}

- (void)saveImageIntoAlbum {
    // 1. 将照片保存进[Camera Roll]相册
    PHFetchResult *createdAsset = self.createdAsset;
    
    // 2. 创建\获取 以应用名命名的自定义相册
    PHAssetCollection *createdCollection = self.createdAssetCollection;
    
    // 3 将图片引用到自定义相册中
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection] insertAssets:createdAsset atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"failed"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } else {
        [SVProgressHUD showSuccessWithStatus:@"successed"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (IBAction)savePicture {
    // 先前的授权状态
    PHAuthorizationStatus previousStatus = [PHPhotoLibrary authorizationStatus];
    /*
     PHAuthorizationStatusNotDetermined = 0,
     PHAuthorizationStatusRestricted,
     PHAuthorizationStatusDenied,
     PHAuthorizationStatusAuthorized
     */
    
    /**
     *  1>如果是应用安装后第一次保存，授权状态为PHAuthorizationStatusNotDetermined
          这个方法会弹出授权框，提示用户决定是否授权，并将用户的授权结果传进block
     *  2>如果不是第一次，这个方法会直接取得此时的授权结果，传给block，而不会弹窗
     *
     *  注意：这个方法的block是在子线程中执行的
     */
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        // 子线程中执行
//        JKLog(@"%@", [NSThread currentThread])
        
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusDenied: {
                    if (previousStatus == PHAuthorizationStatusNotDetermined) return;
                    
                    [SVProgressHUD showErrorWithStatus:@"请开启授权"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                }
                    
                case PHAuthorizationStatusAuthorized: {
                    [self saveImageIntoAlbum];
                    break;
                }
                    
                case PHAuthorizationStatusRestricted: {
                    [SVProgressHUD showErrorWithStatus:@"系统限制导致无法保存"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                }
                    
                default:
                    break;
            }
        });
    }];
    
}

/*
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"failed"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"successed"];
    }
}
*/













@end

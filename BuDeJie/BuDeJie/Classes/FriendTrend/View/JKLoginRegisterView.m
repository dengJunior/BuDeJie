//
//  JKLoginRegisterView.m
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "JKLoginRegisterView.h"

@interface JKLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation JKLoginRegisterView

+ (instancetype)loginView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:kNilOptions][0];
}

+ (instancetype)registerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:kNilOptions][1];
}

- (void)awakeFromNib {
    UIImage *image = [UIImage imageNamed:@"loginBtnBg"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5-1, image.size.width * 0.5-1) resizingMode:UIImageResizingModeStretch];
    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *imageHL = [UIImage imageNamed:@"loginBtnBgClick"];
    imageHL = [imageHL resizableImageWithCapInsets:UIEdgeInsetsMake(imageHL.size.height * 0.5, imageHL.size.width * 0.5, imageHL.size.height * 0.5-1, imageHL.size.width * 0.5-1) resizingMode:UIImageResizingModeStretch];
    [_loginBtn setBackgroundImage:imageHL forState:UIControlStateHighlighted];
    
}

/** 点击登录按钮 */
- (IBAction)loginBtnClick {
}
- (IBAction)forgetPwdBtn {
}

@end

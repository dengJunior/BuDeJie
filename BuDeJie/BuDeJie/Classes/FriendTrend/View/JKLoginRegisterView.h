//
//  JKLoginRegisterView.h
//  BuDeJie
//
//  Created by Joker on 16/7/13.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKLoginRegisterView : UIView

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;

+ (instancetype)loginView;
+ (instancetype)registerView;

@end

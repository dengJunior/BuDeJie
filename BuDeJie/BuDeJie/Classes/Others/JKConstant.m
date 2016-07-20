

#import <UIKit/UIKit.h>

/*
 #define navMaxY 64
 #define titleHeight 35
 #define titleMaxY (navMaxY + titleHeight)
 #define tabBarHeight 49
 */
/** 底部tabBar的高度 */
CGFloat const tabBarHeight = 49;

/** 导航栏最低点的Y值 */
CGFloat const navMaxY = 64;

/** 标题栏的高度 */
CGFloat const titleHeight = 35;

/** 标题栏最低点Y值 */
CGFloat const titleMaxY = (navMaxY + titleHeight);

/** 间距 */
CGFloat const JKMargin = 10;

/** 请求数据的URL */
NSString *const JKRequestURL = @"http://api.budejie.com/api/api_open.php";

/** 请求数据的URL */
NSString *const JKTabBarButtonReclickedNotification = @"JKTabBarButtonReclickedNotification";



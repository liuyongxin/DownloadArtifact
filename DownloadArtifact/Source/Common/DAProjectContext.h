//
//  DAProjectContext.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
//屏幕 Frame 定义
#define ScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen]bounds].size.height)

#define ScreenStatusBarHeight MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)		// 动态获取系统状态栏高度

#define kStatusBarHeight 20
#define kNavigationBarHeight 44
#define kTabBarHeight      49

#define AppDelegate [[UIApplication sharedApplication] delegate]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.0 green:((rgbValue >> 8) & 0xFF)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0]
#define UIColorFromHexStr(str) [UIColor colorWithHexStr:(str)]
#define ThemeColorWithID(ThemeID) [SingleThemeManager.currentThemeStyle colorWithID:ThemeID]

#define ProjectContext [DAProjectContext sharedInstance]
@interface DAProjectContext : NSObject

SINGLETON_T_FOR_HEADER(DAProjectContext);

@end

//
//  DAThemeManager.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/18.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SingleThemeManager  [DAThemeManager sharedDAThemeManager]
#define kThemeChangeNotification @"ThemeChangeNotification"

@interface DAThemeStyleBase : NSObject

@property(nonatomic,retain)NSDictionary* themeConfig;
@property(nonatomic,retain)NSString *themeName;
@property(nonatomic,copy)NSString *iconPrefix;
//根据当前的环境全局设置navigation的样式
-(void)setupNavigationStyleForViewCtrl:(UIViewController *)ctrl;
//从主题配置文件中获取颜色值
-(UIColor *)colorWithKey:(NSString*)key;
//跟聚颜色编号获取颜色值
-(UIColor *)colorWithID:(NSUInteger)colorId;
-(NSString*)colorStrWithID:(NSUInteger)colorId;

@end

@interface DAThemeManager : NSObject

SINGLETON_T_FOR_HEADER(DAThemeManager)

@property(nonatomic,retain)NSMutableDictionary <NSString *,DAThemeStyleBase *>*themeMapping;
@property(nonatomic,retain,readonly)DAThemeStyleBase *currentThemeStyle;

//切换主题入口
-(void)changeThemeWithThemeID:(NSString *)currentThemeID;

@end

@interface UIImage (ThemeManager)

+ (UIImage *)theme_imageNamed:(NSString *)imageName;

@end

//
//  DAThemeManager.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/18.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAThemeManager.h"

@interface DAThemeStyleBase()

@property(nonatomic,retain)NSCache *colorPool;

@end

@implementation DAThemeStyleBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colorPool = [[NSCache alloc]init];
        _colorPool.countLimit = 30;
    }
    return self;
}

-(void)setupNavigationStyleForViewCtrl:(UIViewController *)ctrl
{
    UIColor *tintColor = [self tintColor];
    ctrl.navigationController.navigationBar.translucent = NO;
    ctrl.navigationController.navigationBar.barTintColor = tintColor;
    [ctrl.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

//从主题配置文件中获取颜色值
-(UIColor *)colorWithKey:(NSString*)key{
    UIColor *color = [_colorPool objectForKey:key];
    if (!color) {
        if (key.length > 0 && self.themeConfig.count > 0) {
            NSString *colVal = [self.themeConfig objectForKey:key];
            if (colVal.length > 0)
            {
                if ([colVal hasPrefix:@"$"])//代表颜色引用
                {
                    color   = [self colorWithKey:[colVal substringFromIndex:1]];
                }
                else
                {
                    color   = UIColorFromHexStr(colVal);
                    [_colorPool setObject:color forKey:key];
                }
            }
        }
    }
    if (!color) {
        color = [UIColor blackColor];
    }
    return color;
}

-(UIColor *)colorWithID:(NSUInteger)colorId
{
    NSString *Key = [NSString stringWithFormat:@"c%lu",(unsigned long)colorId];
    return [self colorWithKey:Key];
}

-(NSString *)colorStrWithID:(NSUInteger)colorId
{
    NSString *key = [NSString stringWithFormat:@"c%lu",(unsigned long)colorId];
    NSString *colVal = [self.themeConfig objectForKey:key];
    if (colVal.length > 0)
    {
        if ([colVal hasPrefix:@"$"])//代表颜色引用
        {
            colVal   = [self.themeConfig objectForKey:[key substringFromIndex:1]];
        }
    }
    return colVal;
}

-(UIColor *)tintColor
{
    return ThemeColorWithID(1);
}

@end

@implementation DAThemeManager

SINGLETON_T_FOR_CLASS(DAThemeManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.themeMapping = [NSMutableDictionary dictionary];
        NSString *val = [[NSUserDefaults standardUserDefaults]objectForKey:@"kUserThemeID"];
        if (val) {
            [self updateThemeWithThemeID:val needNotify:NO];
        }
        else
        {
            [self updateThemeWithThemeID:@"Theme1" needNotify:NO];
        }
    }
    return self;
}

-(DAThemeStyleBase*)getCfgWithThemeKey:(NSString*)key
{
    DAThemeStyleBase *cfg = [self.themeMapping objectForKey:key];
    if (!cfg) {
        NSString *cfgPath = [[NSBundle mainBundle] pathForResource:key ofType:@"strings"];
        cfg = [[DAThemeStyleBase alloc]init];
        cfg.themeConfig = [NSDictionary dictionaryWithContentsOfFile:cfgPath];
        cfg.themeName = key;
        if (cfg) {
            [_themeMapping setObject:cfg forKey:key];
        }
    }
    return cfg;
}

-(void)updateThemeWithThemeID:(NSString *)themeID needNotify:(BOOL)need
{
    _currentThemeStyle= [self getCfgWithThemeKey:themeID];
    if (need) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeChangeNotification object:self.currentThemeStyle userInfo:@{@"changeTo":themeID}];
    }
}

//切换主题入口
-(void)changeThemeWithThemeID:(NSString *)currentThemeID;
{
    [self updateThemeWithThemeID:currentThemeID needNotify:YES];
    [[NSUserDefaults standardUserDefaults]setObject:currentThemeID forKey:@"kUserThemeIdx"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end

@implementation UIImage (ThemeManager)

+ (UIImage *)theme_imageNamed:(NSString *)imageName
{
    return [self imageNamed:[NSString stringWithFormat:@"%@_%@",SingleThemeManager.currentThemeStyle.iconPrefix,imageName]];
}

@end

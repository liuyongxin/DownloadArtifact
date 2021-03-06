//
//  DAAppDelegate.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAAppDelegate.h"
#import "DALeftController.h"

@interface DAAppDelegate()
{
    MMDrawerController *_drawerController;
}

@end

@implementation DAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initRootViewController];
    [self setup3DTouch:application];
    return YES;
}

- (void)initRootViewController
{
    _centerTabBarController = [[DACenterTabBarController alloc]init];
    DALeftController *leftController = [[DALeftController alloc]init];

    _drawerController = [[MMDrawerController alloc]initWithCenterViewController:_centerTabBarController leftDrawerViewController:leftController rightDrawerViewController:nil];
    _drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    _drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    _drawerController.maximumLeftDrawerWidth = ScreenWidth * 0.8;
    _drawerController.maximumRightDrawerWidth = ScreenWidth * 0.8;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = _drawerController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)setEnableDrawerGesture:(BOOL)enableDrawerGesture
{
    _enableDrawerGesture = enableDrawerGesture;
    if (enableDrawerGesture) {
        _drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        _drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    }
    else
    {
        _drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
        _drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    }
}

#pragma mark -- MMDrawerController
- (void)closeDrawer:(void(^)(BOOL finished))completion
{
       [_drawerController closeDrawerAnimated:YES completion:completion];
}

- (void)openDrawerSide:(MMDrawerSide)drawerSide completion:(void(^)(BOOL finished))completion
{
    [_drawerController openDrawerSide:drawerSide animated:YES completion:completion];
}

/**
 设置3Dtouch菜单
 */
- (void)setup3DTouch:(UIApplication *)application
{
    UIApplicationShortcutIcon *shortcutIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *shortcutItem = [[UIApplicationShortcutItem alloc]initWithType:@"Search" localizedTitle:@"扫码" localizedSubtitle:@"快速扫码" icon:shortcutIcon userInfo:nil];
    application.shortcutItems = @[shortcutItem];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"Search"])
    {
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {  //应用即将终止
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

@end

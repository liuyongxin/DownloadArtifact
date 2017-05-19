//
//  DACenterTabBarController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DACenterTabBarController.h"
#import "DADownloadRootController.h"
#import "DASearchRootController.h"

@interface DACenterTabBarController ()<UITabBarDelegate>

@end

@implementation DACenterTabBarController

- (void)initBasicData
{
    [super initBasicData];
    [self setupTabBarData];
}

- (void)loadUIData
{
    [super loadUIData];
    self.view.backgroundColor = [UIColor whiteColor];
    DAAppDelegate* appDelegate = (DAAppDelegate*)AppDelegate;
    appDelegate.enableDrawerGesture = YES;
    [self setupTabBarControllers];
}

- (void)setupTabBarData
{
    //不让他显示他父类的 tab bar，显示他自己的tabart
    self.tabBarTitles = @[@"查询",@"下载"];
    NSArray *tabIconNames = @[@"",@""];
    NSMutableArray *icons = [NSMutableArray array];
    for (NSString *name in tabIconNames) {
        UIImage *img = [UIImage imageNamed:name];
        if(img)
        {
            [icons addObject:img];
        }
    }
    self.tabBarIcons = [NSArray arrayWithArray:icons];
    tabIconNames = @[@"",@""];
    icons = [NSMutableArray array];
    for (NSString *name in tabIconNames) {
        UIImage *img = [UIImage imageNamed:name];
        if(img)
        {
            [icons addObject:img];
        }
    }
    self.tabBarSelectedIcons = [NSArray arrayWithArray:icons];
    self.tabBarIconBgImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(10, 10) alpha:8];
    self.tabBarIconBgSelectedImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(10, 10) alpha:.8];
    self.tabBarItemTitleColor = [UIColor blackColor];
    self.tabBarItemSelectedTitleColor = [UIColor colorWithRed:0.00 green:0.57 blue:0.95 alpha:1.00];
    self.fontSize = 15;
}

-(void)setupTabBarControllers
{
    DADownloadRootController *downloadRootController = [[DADownloadRootController alloc]init];
    DANavigationController *downloadRootNav = [[DANavigationController alloc]initWithRootViewController:downloadRootController];
    DASearchRootController *searchRootController = [[DASearchRootController alloc]init];
    DANavigationController *searchRootNav = [[DANavigationController alloc]initWithRootViewController:searchRootController];
    self.tabBarVCs = @[searchRootNav,downloadRootNav];
    [self switchTabBarViewCtrlWithIndex:0];

    self.daTabBar.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - tabbar delegate & self protected method
- (void)commonTabBar:(DATabBarView *)tabbar tabItemDidSelectedWithIndex:(NSUInteger)idx
{
    [super tabBar:tabbar tabItemDidSelectedWithIndex:idx];
}

- (void)commonTabBarViewCtrl:(DATabBarController *)ctrl didSwitchTabBarViewControllerFromOldVC:(UIViewController *)oldVC toVC:(UIViewController *)targetVC
{
    [super tabBarViewCtrl:ctrl didSwitchTabBarViewControllerFromOldVC:oldVC toVC:targetVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //把vc全部释放掉
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    self.tabBarVCs = nil;
}

@end

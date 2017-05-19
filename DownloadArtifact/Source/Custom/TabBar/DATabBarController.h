//
//  DATabBarController.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAViewController.h"
#import "DATabBarView.h"

static CGFloat kDATabBarHeight = 49;

@interface DATabBarController : DAViewController

@property(nonatomic,retain) DATabBarView *daTabBar;
@property(nonatomic,retain) NSArray *tabBarVCs;
@property(nonatomic,retain) NSArray *tabBarTitles;
@property(nonatomic,retain) NSArray *tabBarIcons;
@property(nonatomic,retain) NSArray *tabBarSelectedIcons;
@property(nonatomic,retain) NSArray *tabBarFuncIds;
@property(nonatomic,retain) UIImage *tabBarIconBgImage;
@property(nonatomic,retain) UIImage *tabBarIconBgSelectedImage;
@property(nonatomic,retain) UIColor *tabBarItemTitleColor;
@property(nonatomic,retain) UIColor *tabBarItemSelectedTitleColor;
@property (nonatomic) CGFloat fontSize;
@property(nonatomic,readonly) NSUInteger selectedTabBarIndex;
@property(nonatomic,readonly) UIViewController *currentTabBarViewCtrl;

-(void)setTabBarViewHidden:(BOOL)isHidden;

-(void)switchTabBarViewCtrlWithIndex:(NSUInteger)idx;

//Protected method t, you must call super method before you overide it
-(void)tabBar:(DATabBarView *)tabbar tabItemDidSelectedWithIndex:(NSUInteger)idx;

-(void)tabBarViewCtrl:(DATabBarController*)ctrl didSwitchTabBarViewControllerFromOldVC:(UIViewController*)oldVC toVC:(UIViewController*)targetVC;
//重复选择当前的tabbar
-(void)tabBarCtrlDidReSelectedCurrentIndex:(DATabBarController *)ctrl;

- (UIViewController *)currentVisibleViewControler;
- (UINavigationController *)currentNavigationViewControler;
- (UIViewController *)viewControllerWithIndex:(int)index;

@end

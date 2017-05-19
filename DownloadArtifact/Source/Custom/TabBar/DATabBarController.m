//
//  DATabBarController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DATabBarController.h"

@interface DATabBarController ()< DATabBarViewDelegate>
{
    UIView *_bodyView;
    NSUInteger _itemCount;
}
@end

@implementation DATabBarController

- (void)initBasicData
{
    [super initBasicData];
    _selectedTabBarIndex = -1;
}

- (void)loadUIData
{
    [super loadUIData];
    ( _tabBarIcons.count > _tabBarTitles.count) ? (_itemCount = _tabBarIcons.count) : (_itemCount = _tabBarTitles.count);
    
    CGRect tabBarFrame = CGRectMake(0, self.view.sizeHeight - kDATabBarHeight, self.view.sizeWidth, kDATabBarHeight);
    //init tabbar items
    NSMutableArray *itemBars = [NSMutableArray array];
    for (int i = 0; i<_itemCount; i++) {
        DATabBarItem *item = [[DATabBarItem alloc]initWithFrame:CGRectMake(0, 0, tabBarFrame.size.width/_itemCount, tabBarFrame.size.height)];
        if (_tabBarTitles.count > i) {
            item.title = _tabBarTitles[i];
        }
        if (_tabBarIcons.count > i) {
            item.icon = _tabBarIcons[i];
        }
        if (_tabBarSelectedIcons.count) {
            item.selectedIcon = _tabBarSelectedIcons[i];
        }
        item.selectedBgImage = self.tabBarIconBgSelectedImage;
        item.bgImage = self.tabBarIconBgImage;
        item.labelTitleColor = _tabBarItemTitleColor;
        item.labelTitleSelectedColor = _tabBarItemSelectedTitleColor;
        item.fontSize = _fontSize;
        [item setupView];
        [itemBars addObject:item];
    }
    _bodyView = [[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
    _bodyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _bodyView.backgroundColor = [UIColor clearColor];
    _bodyView.clipsToBounds = NO;
    [self.view addSubview:_bodyView];
    self.daTabBar = [[DATabBarView alloc]initWithFrame:tabBarFrame withCommonTabBarItems:itemBars];
    _daTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _daTabBar.delegate = self;
}

-(void)updateLayout
{
    [super updateLayout];
    [self.currentVisibleViewControler.view bringSubviewToFront:_daTabBar];
}

- (void)didReceiveMemoryWarning
{
    // 不要调用父类的方法（因为cmviewcontroller会清除self。view，导致该页面重新加载所有的controller出现问题
    //    [super didReceiveMemoryWarning];
}

#pragma mark - common tab bar delegate
-(void)tabBarViewCtrl:(DATabBarController*)ctrl didSwitchTabBarViewControllerFromOldVC:(UIViewController*)oldVC toVC:(UIViewController*)targetVC
{
    [_bodyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [oldVC removeFromParentViewController];
    [self addChildViewController:targetVC];
    targetVC.view.originPoint = CGPointZero;
    //   解决打电话时显示错乱的问题
    targetVC.view.frame = _bodyView.bounds;
    targetVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_bodyView addSubview:targetVC.view];
    [targetVC didMoveToParentViewController:self];
}

-(void)tabBar:(DATabBarView *)tabbar tabItemDidSelectedWithIndex:(NSUInteger)idx
{
    if (idx == _selectedTabBarIndex && self.currentTabBarViewCtrl) {
        [self tabBarCtrlDidReSelectedCurrentIndex:self];
    }else{
        UIViewController *oldVC = self.currentTabBarViewCtrl;
        _selectedTabBarIndex = idx;
        UIViewController *toVC = self.currentTabBarViewCtrl;
        if (toVC) {
            [self tabBarCtrlSwitchSelectedAtIndex:oldVC];
            [self tabBarViewCtrl:self didSwitchTabBarViewControllerFromOldVC:oldVC toVC:toVC];
        }
    }
}

- (void)tabBarCtrlSwitchSelectedAtIndex:(UIViewController *)ctrl
{

}

-(void)tabBarCtrlDidReSelectedCurrentIndex:(DATabBarController *)ctrl
{

}

#pragma mark - util method
-(UIViewController *)currentTabBarViewCtrl
{
    if (_tabBarVCs.count > _selectedTabBarIndex) {
        return [self.tabBarVCs objectAtIndex:_selectedTabBarIndex];
    }else{
        return nil;
    }
}

-(void)setTabBarViewHidden:(BOOL)isHidden
{
    self.daTabBar.hidden = isHidden;
}

-(void)switchTabBarViewCtrlWithIndex:(NSUInteger)idx
{
    [self.daTabBar selectTabBarIndex:idx];
}

- (UIViewController *)currentVisibleViewControler
{
    UIViewController *vc = [self currentTabBarViewCtrl];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)vc;
        return nav.visibleViewController;
    }else{
        return vc;
    }
}

- (UINavigationController *)currentNavigationViewControler
{
    UIViewController *vc = [self currentTabBarViewCtrl];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)vc;
        if ([nav.visibleViewController isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nav.visibleViewController;
        }else{
            return nav;
        }
    }else{
        return nil;
    }
}

- (UIViewController *)viewControllerWithIndex:(int)index
{
    return [self.tabBarVCs objectAtIndex:index];
}

@end

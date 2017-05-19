//
//  DAAppDelegate.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "DACenterTabBarController.h"

@interface DAAppDelegate : UIResponder

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign)BOOL enableDrawerGesture;  //是否支持左右视图手势
@property(nonatomic,retain)DACenterTabBarController *centerTabBarController;

- (void)closeDrawer:(void(^)(BOOL finished))completion;
- (void)openDrawerSide:(MMDrawerSide)drawerSide completion:(void(^)(BOOL finished))completion;

@end

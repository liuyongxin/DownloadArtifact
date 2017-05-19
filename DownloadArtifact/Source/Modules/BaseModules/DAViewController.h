//
//  DAViewController.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/17.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DANavigationController.h"

@interface DAViewController : UIViewController

@property(nonatomic,assign)BOOL isFirstTime;
@property(nonatomic,assign)BOOL isAppear;
@property(nonatomic,assign)BOOL showNav;
@property(nonatomic,assign)BOOL showTabBar;

-(void)updateLayout;
- (BOOL)isVisible;
- (void)initBasicData;
- (void)loadUIData;

@end

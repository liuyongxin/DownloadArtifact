//
//  DABaseViewController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DABaseViewController.h"

@interface DABaseViewController ()

@end

@implementation DABaseViewController

- (void)initBasicData
{
    [super initBasicData];
}

- (void)loadUIData
{
    [super loadUIData];
    [SingleThemeManager.currentThemeStyle setupNavigationStyleForViewCtrl:self];
    DAAppDelegate* appDelegate = (DAAppDelegate*)AppDelegate;
    appDelegate.enableDrawerGesture = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DAViewController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/17.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAViewController.h"
#import "DAAppDelegate.h"

@interface DAViewController ()

@end

@implementation DAViewController

-(void)updateLayout
{
    [self.view layoutIfNeeded];
}

- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBasicData];
    }
    return self;
}

- (void)initBasicData
{
    self.objectTag = [self uuidString];
    self.isFirstTime = YES;
    self.showNav = YES;
    self.showTabBar = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self loadUIData];
}

- (void)loadUIData
{
    if (self.showNav && self.navigationController) {
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    else
    {
        self.navigationController.navigationBarHidden = YES;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    if (self.showTabBar) {
        DAAppDelegate *appDelegate = (DAAppDelegate *)[UIApplication sharedApplication].delegate;
        [self.view  addSubview:appDelegate.centerTabBarController.daTabBar];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isAppear = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isFirstTime) {
            self.isFirstTime = NO;
        }
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DAReatNativeRootController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAReatNativeRootController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface DAReatNativeRootController ()

@end

@implementation DAReatNativeRootController

- (void)initBasicData
{
    [super initBasicData];
}

- (void)loadUIData
{
    [super loadUIData];
   NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"DownloadArtifact"
                                                  initialProperties:nil
                                                      launchOptions:nil];
    self.view = rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

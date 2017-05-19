//
//  DAWebViewController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/19.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAWebViewController.h"
#import <WebKit/WebKit.h>

@interface DAWebViewController () <WKNavigationDelegate>

@property(nonatomic,retain)WKWebView *webView;

@end

@implementation DAWebViewController

- (void)initBasicData
{
    [super initBasicData];
}
- (void)loadUIData
{
    [super loadUIData];
    self.title = @"查询";
    [self createWebView];
}

- (void)createWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    if([[UIDevice currentDevice] systemVersion].floatValue >= 10.0f)
    {
        config.ignoresViewportScaleLimits = YES;
    }
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavigationBarHeight - kStatusBarHeight) configuration:config];
    [self.view addSubview:_webView];
}

- (void)loadWebViewRequest:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.urlStr) {
        [self loadWebViewRequest:self.urlStr];
        self.urlStr = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end

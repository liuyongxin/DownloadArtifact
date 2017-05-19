//
//  DAWebViewController.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/19.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAViewController.h"

@interface DAWebViewController : DAViewController

@property(nonatomic,copy)NSString *urlStr;
- (void)loadWebViewRequest:(NSString *)urlStr;

@end

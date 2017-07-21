//
//  DADownloadRootController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DADownloadRootController.h"

@interface DADownloadRootController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UISegmentedControl  *segmentCtr;
@property(nonatomic,retain)UITableView *downloadingTableView;  //正在下载
@property(nonatomic,retain)UITableView *downloadCompletesTableView;//下载完成

@end

@implementation DADownloadRootController

- (void)initBasicData
{
    [super initBasicData];
    self.showTabBar = YES;
}

- (void)loadUIData
{
    [super loadUIData];
    self.title = @"下载";
    [self setupTitleItem];
}

 -(UITableView *)downloadingTableView
{
    if (!_downloadingTableView) {
        _downloadingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
        _downloadingTableView.delegate = self;
        _downloadingTableView.dataSource = self;
        _downloadingTableView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_downloadingTableView];
        _downloadingTableView.tableFooterView = [UIView new];
    }
    return _downloadingTableView;
}

- (UITableView *)downloadCompletesTableView
{
    if (!_downloadCompletesTableView) {
        _downloadCompletesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
        _downloadCompletesTableView.delegate = self;
        _downloadCompletesTableView.dataSource = self;
        [self.view addSubview:_downloadCompletesTableView];
        _downloadCompletesTableView.tableFooterView = [UIView new];
    }
    return _downloadCompletesTableView;
}

- (void)setupTitleItem
{
    CGFloat segCtrWidth = 220;
    CGFloat segCtrHeight = 35;
    _segmentCtr = [[UISegmentedControl alloc]initWithItems:@[@"下载中",@"已完成"]];
    _segmentCtr.frame = CGRectMake((ScreenWidth - segCtrWidth)/2, 0, segCtrWidth, segCtrHeight);
    [_segmentCtr setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeColorWithID(2)} forState:UIControlStateNormal];
    [_segmentCtr setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeColorWithID(1)} forState:UIControlStateSelected];
    [_segmentCtr setBackgroundImage:[UIImage imageWithColor:ThemeColorWithID(1)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segmentCtr setBackgroundImage:[UIImage imageWithColor:ThemeColorWithID(2)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    _segmentCtr.borderColor = ThemeColorWithID(2);
    _segmentCtr.borderWidth = 0.5;
    [_segmentCtr addTarget:self action:@selector(segmentCtrAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentCtr];
    [self.segmentCtr setSelectedSegmentIndex:0];
    [self segmentCtrAction:self.segmentCtr];
    self.navigationItem.titleView = _segmentCtr;
}

- (void)segmentCtrAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.downloadingTableView.hidden = NO;
        self.downloadCompletesTableView.hidden = YES;
    }
    else if (seg.selectedSegmentIndex == 1)
    {
        self.downloadingTableView.hidden = YES;
        self.downloadCompletesTableView.hidden = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end

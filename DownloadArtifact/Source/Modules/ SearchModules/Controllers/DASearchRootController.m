//
//  DASearchRootController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DASearchRootController.h"
#import "DAWebViewController.h"
#import "DAButton.h"
#import "YXScanCode.h"

@interface DASearchRootController ()
{
    NSInteger _index;
}
@property(nonatomic,retain)NSMutableArray *searchWebsiteUrlStrArr;
@property(nonatomic,retain)NSMutableArray *searchWebsiteTitleArr;
@property(nonatomic,retain)NSMutableArray *searchWebsiteImageArr;
@property(nonatomic,retain)UITextField *searchTextField;
@property(nonatomic,retain)UISegmentedControl *segCtr;
@property(nonatomic,retain)YXScanCode *scanCodeView;

@end

@implementation DASearchRootController

- (void)initBasicData
{
    [super initBasicData];
    _searchWebsiteUrlStrArr = [[NSMutableArray alloc]init];
    [_searchWebsiteUrlStrArr addObject:@"https://wap.baidu.com"];//百度
    [_searchWebsiteUrlStrArr addObject:@"http://www.google.cn"]; //谷歌中国
    [_searchWebsiteUrlStrArr addObject:@"http://www.google.com"];//谷歌
    _searchWebsiteTitleArr = [[NSMutableArray alloc]initWithArray:@[@"百度",@"谷歌中国",@"谷歌"]];
    _searchWebsiteImageArr = [[NSMutableArray alloc]initWithArray:@[@"baidu_web",@"google_web",@"google_web"]];
    _index = 0;
    self.showTabBar = YES;
}

- (void)loadUIData
{
    [super loadUIData];
    self.title = @"查询";
//    [self createSearchView];
    _scanCodeView = [[YXScanCode alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scanCodeView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_scanCodeView captureAction];
}

- (void)createSearchView
{
    CGFloat space = 20;
    CGFloat xAxis = (ScreenWidth - 150 - 60 - space)/2;
    CGFloat yAxis = space;
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, 150, 30)];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_searchTextField];
    xAxis += 150 + space;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(xAxis, yAxis, 60, 30);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"button_blue_n"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"button_blue_h"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    yAxis += 30 + space;
    CGFloat x = (ScreenWidth - 150 - 60 - space)/2;
    for (int i = 0; i < 3; i++) {
        DAButton *btn = [DAButton buttonWithFrame:CGRectMake(x, yAxis, 80, 30) ImageTextAlignmentType:ImageTextAlignmentTypeLeftRight];
        [btn setImage:[UIImage imageNamed:@"checkbox_normal.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
        [btn setTitle:_searchWebsiteTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:btn];
        x += 60 + space;
        if (i == 0) {
            btn.selected = YES;
        }
    }
}

- (void)btnAction:(UIButton *)btn
{
    UIButton *btn1 = [self.view viewWithTag:100];
    UIButton *btn2 = [self.view viewWithTag:101];
    UIButton *btn3 = [self.view viewWithTag:102];
    btn.selected = YES;
    if (btn == btn1) {
        btn2.selected = NO;
        btn3.selected = NO;
        _index = 0;
    }
    else if (btn == btn2)
    {
        btn1.selected = NO;
        btn3.selected = NO;
        _index = 1;
    }
    else if (btn == btn3)
    {
        btn1.selected = NO;
        btn2.selected = NO;
        _index = 2;
    }
}

- (void)searchAction:(UIButton *)btn
{
    DAWebViewController *webController = [[DAWebViewController alloc]init];
    webController.urlStr = _searchWebsiteUrlStrArr[_index];
    webController.title = _searchWebsiteTitleArr[_index];
    [self.navigationController pushViewController:webController animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

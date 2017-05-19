//
//  DAVideoPlayerController.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/17.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAVideoPlayerController.h"
#import "ZFPlayerControlView.h"

@interface DAVideoPlayerController ()<ZFPlayerDelegate>

@property(nonatomic,retain)ZFPlayerView *playerView;

@end

@implementation DAVideoPlayerController

- (void)initBasicData
{
    [super initBasicData];

}

- (void)loadUIData
{
    [super loadUIData];
}

- (void)setupVideoPlayer
{
    CGRect playerRect = CGRectMake(0, 0, ScreenWidth, 200);
    _playerView = [[ZFPlayerView alloc]init];
    _playerView.frame = playerRect;
    _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    _playerView.hasDownload = YES; //断点续传
    _playerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_playerView];
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc]init];
    playerModel.fatherView = self.view;
    playerModel.videoURL = [NSURL URLWithString:@""];
    playerModel.title = @"";
    [self.playerView playerControlView:controlView playerModel:playerModel];
    self.playerView.delegate = self;
    [self.playerView autoPlayTheVideo];
}


/** 返回按钮事件 */
- (void)zf_playerBackAction
{

}
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url
{

}

@end

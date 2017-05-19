//
//  UIView+RedPoint.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DZHRedPointProtocol <NSObject>

-(void)RedPoint:(UIView*)point didChangeTo:(BOOL)hidden;

@end

@interface UIView (RedPoint)

@property(nonatomic,assign)id<DZHRedPointProtocol> rpDelegate;
@property(nonatomic,readonly) UIView *redNoticePoint;
-(void)redNoticePointSetCount:(NSInteger)count;

@end


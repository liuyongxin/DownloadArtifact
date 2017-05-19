//
//  UIView+RedPoint.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#define RED_NOTICE_POINT_TAG 2199
#define RED_NOTICE_POINTCount_TAG 2200

#import "UIView+RedPoint.h"

@implementation UIView (RedPoint)

-(UIView *)redNoticePoint
{
    UIView *redPoint = [self viewWithTag:RED_NOTICE_POINT_TAG];
    if (!redPoint) {
        redPoint = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        redPoint.tag = RED_NOTICE_POINT_TAG;
        redPoint.backgroundColor = [UIColor redColor];
        redPoint.hidden = YES;
        [self addSubview:redPoint];
        redPoint.centerY = 8;
        redPoint.centerX = self.sizeWidth - 10;
        redPoint.cornerRadius = 5;
    }
    return redPoint;
}

-(void)redNoticePointSetCount:(NSInteger)count;
{
    if (count == 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
        NSString *t = [NSString stringWithFormat:@"%@",@(count)];
        UILabel *lb = [self viewWithTag:RED_NOTICE_POINTCount_TAG];
        if (!lb) {
            lb = [UILabel labelWithText:t fontSize:10 color:[UIColor whiteColor]];
            [self addSubview:lb];
            lb.tag = RED_NOTICE_POINTCount_TAG;
            lb.textAlignment = NSTextAlignmentCenter;
        }
        lb.frame = self.bounds;
        lb.text = t;
    }
}

-(id<DZHRedPointProtocol>)rpDelegate
{
    return objc_getAssociatedObject(self, @selector(rpDelegate));
}
-(void)setRpDelegate:(id<DZHRedPointProtocol>)rpDelegate
{
    objc_setAssociatedObject(self, @selector(rpDelegate), rpDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end

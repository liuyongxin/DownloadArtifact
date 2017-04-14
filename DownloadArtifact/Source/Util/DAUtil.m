//
//  DAUtil.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAUtil.h"
#import <malloc/malloc.h>

@implementation DAUtil

+ (CGFloat)currentDeviceSystemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

//判断是否是有效对象实例
+ (BOOL )isEffectiveObjectInstances:(Class )class object:(id)object
{
    if (object && [self isEffectiveObject:object]) {
        if ([object isMemberOfClass:class]) {
            return YES;
        }
    }
    return NO;
}

//判断是否是有效分配的内存
+ (BOOL )isEffectiveObject:(id)object
{
    return  (malloc_zone_from_ptr((__bridge const void *)(object)) == NULL);
}

@end

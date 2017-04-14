//
//  DAUtil.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DAUtil : NSObject

//当前设备系统版本号
+ (CGFloat)currentDeviceSystemVersion;
//判断是否是有效对象实例
+ (BOOL )isEffectiveObjectInstances:(Class )class object:(id)object;
//判断是否是有效分配的内存
+ (BOOL )isEffectiveObject:(id)object;

@end

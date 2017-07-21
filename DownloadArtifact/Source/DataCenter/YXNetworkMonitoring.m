//
//  YXNetworkMonitoring.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/7/21.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "YXNetworkMonitoring.h"
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import <SystemConfiguration/SystemConfiguration.h>
#import<SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

@implementation YXNetworkMonitoring

+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return @"未知";
    }
    NSArray *wifiArr = (__bridge NSArray*)wifiInterfaces;
    for (NSString *interfaceName in wifiArr) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
    
    NSArray * networkInterfaces = [NEHotspotHelper supportedNetworkInterfaces];
    
    NSLog(@"Networks %@",networkInterfaces);
    
    //获取wifi列表
    
    for(NEHotspotNetwork *hotspotNetwork in [NEHotspotHelper supportedNetworkInterfaces]) {
        
        NSString *ssid = hotspotNetwork.SSID;
        
        NSString *bssid = hotspotNetwork.BSSID;
        
        BOOL secure = hotspotNetwork.secure;
        
        BOOL autoJoined = hotspotNetwork.autoJoined;
        
        double signalStrength = hotspotNetwork.signalStrength;
    }
    
}


@end

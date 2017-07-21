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

/*ios10以下调用系统功能跳转
prefs:root=General&path=About
prefs:root=General&path=ACCESSIBILITY
prefs:root=AIRPLANE_MODE
prefs:root=General&path=AUTOLOCK
prefs:root=General&path=USAGE/CELLULAR_USAGE
prefs:root=Brightness //打开Brightness(亮度)设置界面
prefs:root=Bluetooth //打开蓝牙设置
prefs:root=General&path=DATE_AND_TIME //日期与时间设置
prefs:root=FACETIME //打开FaceTime设置
prefs:root=General //打开通用设置
prefs:root=General&path=Keyboard //打开键盘设置
prefs:root=CASTLE //打开iClound设置
prefs:root=CASTLE&path=STORAGE_AND_BACKUP //打开iCloud下的储存空间
prefs:root=General&path=INTERNATIONAL //打开通用下的语言和地区设置
prefs:root=LOCATION_SERVICES //打开隐私下的定位服务
prefs:root=ACCOUNT_SETTINGS
prefs:root=MUSIC //打开设置下的音乐
prefs:root=MUSIC&path=EQ //打开音乐下的均衡器
prefs:root=MUSIC&path=VolumeLimit //打开音乐下的音量
prefs:root=General&path=Network //打开通用下的网络
prefs:root=NIKE_PLUS_IPOD
prefs:root=NOTES //打开设置下的备忘录设置
prefs:root=NOTIFICATIONS_ID //打开设置下的通知设置
prefs:root=Phone //打开电话设置
prefs:root=Photos //打开设置下照片和相机设置
prefs:root=General&path=ManagedConfigurationList //打开通用下的描述文件
prefs:root=General&path=Reset //打开通用下的还原设置
prefs:root=Sounds&path=Ringtone
prefs:root=Safari //打开设置下的safari设置
prefs:root=General&path=Assistant //打开siri不成功
prefs:root=Sounds //打开设置下的声音设置
prefs:root=General&path=SOFTWARE_UPDATE_LINK //打开通用下的软件更新
prefs:root=STORE //打开通用下的iTounes Store和App Store设置
prefs:root=TWITTER //打开设置下的twitter设置
prefs:root=FACEBOOK //打开设置下的Facebook设置
prefs:root=General&path=USAGE //打开通用下的用量
prefs:root=VIDEO
prefs:root=General&path=Network/VPN //打开通用下的vpn设置
prefs:root=Wallpaper //打开设置下的墙纸设置
prefs:root=WIFI //打开wifi设置
prefs:root=INTERNET_TETHERING
*/

/*ios10调用系统功能跳转
无线局域网 App-Prefs:root=WIFI
蓝牙 App-Prefs:root=Bluetooth
蜂窝移动网络 App-Prefs:root=MOBILE_DATA_SETTINGS_ID
个人热点 App-Prefs:root=INTERNET_TETHERING
运营商 App-Prefs:root=Carrier
通知 App-Prefs:root=NOTIFICATIONS_ID
通用 App-Prefs:root=General
通用-关于本机 App-Prefs:root=General&path=About
通用-键盘 App-Prefs:root=General&path=Keyboard
通用-辅助功能 App-Prefs:root=General&path=ACCESSIBILITY
通用-语言与地区 App-Prefs:root=General&path=INTERNATIONAL
通用-还原 App-Prefs:root=Reset
墙纸 App-Prefs:root=Wallpaper
Siri App-Prefs:root=SIRI
隐私 App-Prefs:root=Privacy
Safari App-Prefs:root=SAFARI
音乐 App-Prefs:root=MUSIC
音乐-均衡器 App-Prefs:root=MUSIC&path=com.apple.Music:EQ
照片与相机 App-Prefs:root=Photos
FaceTime App-Prefs:root=FACETIME
*/
@end

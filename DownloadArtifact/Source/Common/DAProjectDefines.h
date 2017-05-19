//
//  DAProjectDefines.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/4/12.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#ifndef DAProjectDefines_h
#define DAProjectDefines_h

#if BUILD_ENV_CONF == BUILD_ENV_TEST
#import "DATestEnvironmentConfig.h"
#else
#import "DAOfficialEnvironmentConfig.h"
#endif



#import "DASingletonTemplate.h"
#import "DAProjectContext.h"
#import "DAUtil.h"
#import "SmartUtil.h"
#import <objc/runtime.h>
#import "UIView+RedPoint.h"
#import "DAThemeManager.h"

#endif /* DAProjectDefines_h */

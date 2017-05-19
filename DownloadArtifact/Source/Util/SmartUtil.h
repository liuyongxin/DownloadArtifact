//
//  SmartUtil.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Util)

@property(nonatomic,assign) CGFloat originX;
@property(nonatomic,assign) CGFloat originY;
@property(nonatomic,assign) CGPoint originPoint;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign) CGFloat sizeWidth;
@property(nonatomic,assign) CGFloat sizeHeight;
@property(nonatomic,assign) CGSize  sizeWH;
@property(nonatomic,assign) CGFloat cornerRadius;
@property(nonatomic,assign) UIColor *borderColor;
@property(nonatomic,assign) CGFloat borderWidth;
@property(nonatomic,assign,readonly) CGPoint rightBottomCorner;

-(UIImage *)shortCutImage;
-(void)traceString:(NSString*)str;
-(UIColor*)deepColor;
-(void)placeAt:(UIView*)view;
-(void)dumpView;
-(NSString *)dumpString;
-(void)highlightSubviewsWithColor:(UIColor*)color;
-(void)highlightSubviews;
-(void)highlightViewLayers;
- (CGSize)screenSize;

@end

@interface UILabel (Util)

+(UILabel*)labelWithText:(NSString*)text fontSize:(int)size color:(UIColor*)color;
-(void)setFitText:(NSString*)text baseFont:(CGFloat)font;
-(void)setFitSuperView:(NSString *)text baseFont:(CGFloat)font;

@end

@interface UIColor (Util)

+(UIColor *)randomColor;
+(UIColor *)color255WithRed:(int)red green:(int)green blue:(int)blue;
+(UIColor *)colorWithHexStr:(NSString *)hexStr;

@end

@interface UIImage (Util)

+(UIImage*)imageWithColor:(UIColor *)color;
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha;

//NonCachable image getter from bundle
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle;
//NonCachable image getter from main bundle
+ (UIImage *)bundleImageNamed:(NSString *)name;

-(UIImage*)scaledImageToSize:(CGSize)newSize;

-(UIImage*)retinaImage;
-(UIImage*)resizedImageWithLeftCap:(float)x topCap:(float)y;
-(UIImage*)centerResizeImage;

+(UIImage*)imageForCurrentScreen;
-(UIImage*)fillImageWithColor:(UIColor*)color;

@end

typedef void (^SmartControlCallback) (UIControl *sv);
@interface UIControl (BlockActionInvoke)

-(void)bindControlEvent:(UIControlEvents)event Callback:(SmartControlCallback)fn;

@end

@interface UIButton (Util)

+(UIButton*)buttonInsertSuperView:(UIView*)view;

-(void)bindTouchUpInsideEventCallback:(SmartControlCallback)fn;
-(void)bindTouchEvent:(UIControlEvents)event Callback:(SmartControlCallback)fn;

@end

@interface NSString (Util)

-(NSString*)cnNumber;
- (NSDictionary *)queryStringToDic;
- (NSDictionary *)queryParamToDic;
//替换系统的string，防止用他出错
- (BOOL)hasString:(NSString *)subString;
@end

@interface NSObject  (Util)
@property (nonatomic, retain) NSString *objectTag;
/**************************************************************************
 FunctionName:  uuidString
 FunctionDesc:  为对象生成一个UUID标记值
 Parameters:    NONE
 ReturnVal:     NSString
 **************************************************************************/
- (NSString *)uuidString;

/**************************************************************************
 FunctionName:  refreshData
 FunctionDesc:  数据刷新处理
 Parameters:    userInfo:NSDictionary
 ReturnVal:     NONE
 **************************************************************************/
- (void)refreshData:(NSDictionary *)userInfo;
//转成安全的数据
-(NSString*)toValidString;
//有效的字符串定义为类型是字符串并且长度>1
-(BOOL)isValidString;
//有效的数据定义为类型是数据并且长度>1
-(BOOL)isValidArray;
//有效的数据定义为字典而且长度>1
-(BOOL)isValidDictionary;

@end

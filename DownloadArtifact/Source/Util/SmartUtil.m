//
//  SmartUtil.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "SmartUtil.h"

@implementation UIView (Util)

-(void)traceString:(NSString*)str
{
    UITextView *tv= [[UITextView alloc]initWithFrame:self.bounds];
    tv.backgroundColor = [UIColor blackColor];
    tv.textColor = [UIColor whiteColor];
    tv.font = [UIFont systemFontOfSize:12];
    [self addSubview:tv];
    [tv setText:str];
}

-(UIColor*)deepColor
{
    if (![self.superview.backgroundColor isEqual:[UIColor clearColor]]) {
        return self.superview.backgroundColor;
    }else{
        return [self.superview deepColor];
    }
}

-(UIImage *)shortCutImage
{
    UIGraphicsBeginImageContext(self.sizeWH);
    UIGraphicsBeginImageContextWithOptions(self.sizeWH, YES,[UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)placeAt:(UIView*)view
{
    self.frame = view.bounds;
    [view addSubview:self];
}
-(void)setCenterX:(CGFloat)x
{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}
-(void)setCenterY:(CGFloat)y
{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}
-(CGFloat)centerX
{
    return self.center.x;
}
-(CGFloat)centerY
{
    return self.center.y;
}
-(void)setSizeWidth:(CGFloat)sizeWidth
{
    CGRect r = self.frame;
    r.size.width = sizeWidth;
    self.frame = r;
}
-(CGFloat)sizeWidth
{
    return self.frame.size.width;
}
-(void)setSizeHeight:(CGFloat)sizeHeight
{
    CGRect r = self.frame;
    r.size.height = sizeHeight;
    self.frame = r;
}
-(CGFloat)sizeHeight
{
    return self.frame.size.height;
}
-(void)setOriginX:(CGFloat)originX
{
    CGRect r = self.frame;
    r.origin.x = originX;
    self.frame = r;
}
-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(void)setOriginY:(CGFloat)originY
{
    CGRect r = self.frame;
    r.origin.y = originY;
    self.frame = r;
}
-(CGFloat)originY
{
    return self.frame.origin.y;
}
-(void)dumpView
{
    printf("%s\n",[[self tx_recursiveLayoutDescription] UTF8String]);
}
-(NSString *)dumpString
{
    return [self tx_recursiveDescription];
}

- (NSString *)tx_recursiveDescription
{
    NSMutableString *s = [NSMutableString string];
    
    typedef void (^block_t)(UIView *view, int depth);
    
    __weak block_t recurse;
    block_t block;
    recurse = block = ^(UIView *view, int depth)
    {
        NSString *theIndent = [@"" stringByPaddingToLength:depth * 4 withString:@"   |" startingAtIndex:0];
        [s appendFormat:@"%@%@\n", theIndent, [view description]];
        for (UIView *theSubview in view.subviews)
        {
            recurse(theSubview, depth + 1);
        }
    };
    block(self, 0);
    
    return(s);
}

- (NSString *)tx_recursiveLayoutDescription
{
    NSMutableString *s = [NSMutableString string];
    
    typedef void (^block_t)(UIView *view, int depth);
    
    __weak block_t recurse;
    block_t block;
    recurse = block = ^(UIView *view, int depth)
    {
        NSString *theIndent = [@"" stringByPaddingToLength:depth * 4 withString:@"   |" startingAtIndex:0];
        [s appendFormat:@"%@%@\n", theIndent, [view description]];
        for (NSLayoutConstraint *theConstraint in view.constraints)
        {
            [s appendFormat:@"%@   * %@\n", theIndent, [theConstraint description]];
        }
        for (UIView *theSubview in view.subviews)
        {
            recurse(theSubview, depth + 1);
        }
    };
    block(self, 0);
    
    return(s);
}

-(void)highlightSubLayers:(CALayer*)layer
{
    layer.borderWidth = 1.0;
    layer.borderColor = [[UIColor randomColor] CGColor];
    for (CALayer *ll in layer.sublayers) {
        if (layer.sublayers.count > 0) {
            [self highlightSubLayers:ll];
        }
    }
}

-(void)highlightViewLayers
{
    [self highlightSubLayers:self.layer];
}

-(void)highlightSubviewsWithColor:(UIColor*)color
{
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [color CGColor];
    for (UIView *view in self.subviews) {
        if (self.subviews.count>0) {
            [view highlightSubviewsWithColor:color];
        }
    }
}
-(void)highlightSubviews
{
    //use boder wrappered
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor randomColor]CGColor];
    //        view.alpha = .5;
    for (UIView *view in self.subviews) {
        if (self.subviews.count>0) {
            [view highlightSubviews];
        }
    }}

-(CGSize)sizeWH
{
    return self.frame.size;
}
-(void)setSizeWH:(CGSize)sizeWH
{
    CGRect r = self.frame;
    r.size = sizeWH;
    self.frame = r;
}
-(CGPoint)originPoint
{
    return self.frame.origin;
}
-(void)setOriginPoint:(CGPoint)originPoint
{
    CGRect r = self.frame;
    r.origin = originPoint;
    self.frame = r;
}
-(CGPoint)rightBottomCorner
{
    return CGPointMake(self.originX + self.sizeWidth, self.originY + self.sizeHeight);
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
-(UIColor*)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderColor:(UIColor*)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGSize)screenSize
{
    CGSize screenSize               = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(MIN(screenSize.width, screenSize.height), MAX(screenSize.width, screenSize.height));
}

@end

@implementation UILabel (Util)

+(UILabel*)labelWithText:(NSString*)text fontSize:(int)size color:(UIColor*)color
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}

-(void)setFitText:(NSString *)text baseFont:(CGFloat)font
{
    CGFloat f = [self fontForText:text baseFont:font width:self.sizeWidth-5];
    self.font = [UIFont systemFontOfSize:f];
    self.text = text;
}
-(void)setFitSuperView:(NSString *)text baseFont:(CGFloat)font
{
    CGFloat f = [self fontForText:text baseFont:font width:self.superview.sizeWidth - self.originX];
    self.font = [UIFont systemFontOfSize:f];
    self.text = text;
}

-(CGFloat)fontForText:(NSString*)text baseFont:(CGFloat)font width:(CGFloat)width
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:font]];
    if (size.width > width) {
        font = font - 1;
        if (font <= 12) {
            return font;
        }else{
            return [self fontForText:text baseFont:font width:width];
        }
    }else{
        return font;
    }
}

@end

@implementation UIColor (Util)

+(UIColor *)color255WithRed:(int)red green:(int)green blue:(int)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+(UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srandom((unsigned int)time(NULL));
    }
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithHexStr:(NSString *)hexStr
{
    if(hexStr.length<6){
        return [UIColor blackColor];
    }
    if([hexStr hasPrefix:@"#"]){
        hexStr = [hexStr substringFromIndex:1];
    }
    if(hexStr.length<6){
        return [UIColor blackColor];
    }
    
    NSRange range       = NSMakeRange(0, 2);
    NSString *aString   = nil;
    if ([hexStr length] == 8)//argb
    {
        aString         = [hexStr substringWithRange:range];
        range.location  = 2;
    }
    NSString *rString   =[hexStr substringWithRange:range];
    range.location      += 2;
    NSString *gString   =[hexStr substringWithRange:range];
    range.location      += 2;
    NSString *bString   =[hexStr substringWithRange:range];
    
    unsigned a,r,g,b;
    if (aString)
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
    else
        a               = 255;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.];
}

@end

@implementation UIImage (Util)

// get a template image, ignoring its color information
-(UIImage*)fillImageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(UIImage*)scaledImageToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)imageForCurrentScreen
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.sizeWH, YES,[UIScreen mainScreen].scale);
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+(UIImage*)imageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(ctx, 1);
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(ctx, alpha);
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle
{
    NSString *p = [NSString stringWithFormat:@"%@/%@",[bundle bundlePath], name];
    return [UIImage imageWithContentsOfFile:p];
}

+ (UIImage *)bundleImageNamed:(NSString *)name
{
    return [self imageNamed:name bundle:[NSBundle mainBundle]];
}

-(UIImage*)retinaImage
{
    CGImageRef cgimage  = self.CGImage;
    return [UIImage imageWithCGImage:cgimage scale:2.0 orientation:UIImageOrientationUp];
}

-(UIImage*)resizedImageWithLeftCap:(float)x topCap:(float)y
{
    if([self respondsToSelector:@selector(resizableImageWithCapInsets:)]){
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(y, x, y+1, x+1)];
    }
    else{
        return [self stretchableImageWithLeftCapWidth:x topCapHeight:y];
    }
}

-(UIImage*)centerResizeImage
{
    CGSize size = self.size;
    return [self resizedImageWithLeftCap:ceilf(size.width*.5) topCap:ceilf(size.height*.5)];
}

@end

@implementation UIControl (BlockActionInvoke)

-(NSMutableDictionary *)eventHandlerMapping
{
    NSMutableDictionary *map = objc_getAssociatedObject(self, @selector(eventHandlerMapping));
    if (!map) {
        map = [NSMutableDictionary dictionary];
        [self setEventHandlerMapping:map];
    }
    return map;
}

-(void)setEventHandlerMapping:(NSMutableDictionary *)eventHandlerMapping
{
    objc_setAssociatedObject(self, @selector(eventHandlerMapping), eventHandlerMapping, OBJC_ASSOCIATION_RETAIN);
}

void smart_handleCtrlEvent(id self, SEL _cmd, UIControl *sender)
{
    if ([self isKindOfClass:[UIControl class]]) {
        UIControl *ctr = (UIControl*)self;
        NSRange r = [NSStringFromSelector(_cmd) rangeOfString:@"_" options:NSBackwardsSearch];
        if (r.location != NSNotFound) {
            NSInteger type = [[NSStringFromSelector(_cmd) substringFromIndex:r.location+1] integerValue];
            SmartControlCallback block = [ctr.eventHandlerMapping objectForKey:@(type)];
            if (block){
                __weak UIControl *ws = sender;
                block(ws);
            }
        }
    }
}

-(void)bindControlEvent:(UIControlEvents)event Callback:(SmartControlCallback)fn
{
    NSMutableDictionary *map = [self eventHandlerMapping];
    [map setObject:[fn copy]forKey:@(event)];
    
    NSString *selStr = [NSString stringWithFormat:@"sm_invokeControlEventType_%lu",(unsigned long)event];
    SEL sel = NSSelectorFromString(selStr);
    if (class_getInstanceMethod([self class], sel) == NULL) {
        class_addMethod([self class], sel, (IMP)smart_handleCtrlEvent, "v@:@");
    }
    if ([self respondsToSelector:sel]) {
        [self addTarget:self action:sel forControlEvents:event];
    }
}

@end

@implementation UIButton (Util)

+(UIButton*)buttonInsertSuperView:(UIView*)view
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [view insertSubview:btn atIndex:0];
    return btn;
}

-(void)bindTouchEvent:(UIControlEvents)event Callback:(SmartControlCallback)fn
{
    [self bindControlEvent:event Callback:fn];
}

-(void)bindTouchUpInsideEventCallback:(SmartControlCallback)fn
{
    [self bindControlEvent:UIControlEventTouchUpInside Callback:fn];
}

@end

@implementation NSString (Util)

- (BOOL)hasString:(NSString *)subString
{
    if([self isValidString] && [subString isValidString]){
        if ([self rangeOfString:subString].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (NSDictionary *)queryStringToDic
{
    NSInteger loc = [self rangeOfString:@"?"].location;
    NSString *param = loc+1 <= self.length? [self substringFromIndex:loc+1]: self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *pair in [param componentsSeparatedByString:@"&"])
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1)
        {
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            if(key && val)
                [dict setObject:val forKey:key];
        }
    }
    return dict;
}

- (NSDictionary *)queryParamToDic
{
    NSString *param = self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *pair in [param componentsSeparatedByString:@"&"])
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1)
        {
            NSString *key = [elements objectAtIndex:0];
            NSString *val = [elements objectAtIndex:1];
            
            if(key && val)
                [dict setObject:val forKey:key];
        }
    }
    return dict;
}

-(NSString*)cnNumber
{
    long num = [self integerValue];
    NSMutableString *rst = [NSMutableString string];
    if (num/100000000 >= 1) {
        NSString *str = [NSString stringWithFormat:@"%ld亿",num/100000000];
        [rst appendString:str];
        
        num = num % 100000000;
        if (num/10000 >= 1) {
            [rst appendFormat:@"%ld万",num/10000];
        }
    }else{
        num = num % 100000000;
        if (num/10000 >= 1) {
            [rst appendFormat:@"%ld万",num/10000];
        }else{
            return [NSString stringWithFormat:@"%ld元",num];
        }
    }
    return rst;
}
@end

static const char *ObjectTagKey = "ObjectTag";
@implementation NSObject (Util)
@dynamic objectTag;

- (NSString *)objectTag
{
    return objc_getAssociatedObject(self, ObjectTagKey);
}

- (void)setObjectTag:(NSString *)newObjectTag
{
    objc_setAssociatedObject(self, ObjectTagKey, newObjectTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)uuidString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    
    return uuidString;
}

- (void)refreshData:(NSDictionary *)userInfo
{
    
}

-(NSString*)toValidString
{
    if ([self isValidString]) {
        return (NSString*)self;
    }else{
        return @"";
    }
}

-(BOOL)isValidString
{
    if (self) {
        if ([self isKindOfClass:[NSString class]]) {
            return [(NSString*) self length]>0;
        }
    }
    return NO;
}

-(BOOL)isValidArray
{
    if (self) {
        if ([self isKindOfClass:[NSArray class]]) {
            return [(NSArray*) self count]>0;
        }
    }
    return NO;
}

-(BOOL)isValidDictionary
{
    if (self) {
        if ([self isKindOfClass:[NSDictionary class]]) {
            return [(NSDictionary*) self count]>0;
        }
    }
    return NO;
}

@end

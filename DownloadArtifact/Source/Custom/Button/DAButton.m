//
//  DAButton.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/19.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DAButton.h"
#define kTextImageSpace 5

@interface DAButton ()

@property(nonatomic,assign)ImageTextAlignmentType imageTextAlignmentType;

@end

@implementation DAButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    DAButton *btn = [super buttonWithType:buttonType];
    btn.imageTextAlignmentType =ImageTextAlignmentTypeDefault;
    btn.textImageSpace = kTextImageSpace;
    return btn;
}

+ (instancetype)buttonWithFrame:(CGRect)frame ImageTextAlignmentType:(ImageTextAlignmentType )alignmentType
{
   DAButton *btn =   [self buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.imageTextAlignmentType = alignmentType;
    return btn;
}

- (void)addBottomLine:(UIColor *)lineColor lineHeight:(CGFloat )lineHeight
{
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(2, self.frame.size.height - lineHeight, self.frame.size.width - 4, lineHeight);
    line.backgroundColor = lineColor.CGColor;
    [self.layer addSublayer:line];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize imageSize =  [self getImageSizeContentRect:contentRect];
    if (_imageTextAlignmentType == ImageTextAlignmentTypeUpDown) {
        CGRect titleRect = CGRectMake(contentRect.origin.x,contentRect.origin.y + imageSize.height + _textImageSpace, contentRect.size.width, contentRect.size.height - imageSize.height - _textImageSpace);
        return titleRect;
    }
    else if (_imageTextAlignmentType == ImageTextAlignmentTypeLeftRight)
    {
        CGRect titleRect = CGRectMake(contentRect.origin.x + imageSize.width + _textImageSpace, contentRect.origin.y, contentRect.size.width - imageSize.width - _textImageSpace, contentRect.size.height);
        return titleRect;
    }
    else
    {
        return  [super titleRectForContentRect:contentRect];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize imageSize =  [self getImageSizeContentRect:contentRect];
    if (_imageTextAlignmentType == ImageTextAlignmentTypeUpDown) {
        CGRect imageRect = CGRectMake((contentRect.size.width - imageSize.width)/2, contentRect.origin.y, imageSize.width, imageSize.height);
        return imageRect;
    }
   else if (_imageTextAlignmentType == ImageTextAlignmentTypeLeftRight) {
        CGRect imageRect = CGRectMake(contentRect.origin.x, (contentRect.size.height - imageSize.height)/2, imageSize.width, imageSize.height);
        return imageRect;
    }
    else
    {
        return  [super imageRectForContentRect:contentRect];
    }
}

- (CGSize)getImageSizeContentRect:(CGRect)contentRect
{
    UIImage *image = [self imageForState:UIControlStateNormal];
    CGSize imageSize = image.size;
    CGSize imageNewSize = CGSizeZero;
    if (((contentRect.size.width < imageSize.width) && (contentRect.size.height > imageSize.height)) || ((imageSize.width > contentRect.size.width && imageSize.height > contentRect.size.height) && (imageSize.width > imageSize.height)))
    {
        imageSize.height = (contentRect.size.width/imageSize.width)*imageSize.height;
        imageSize.width = contentRect.size.width;
    }
    else if (((contentRect.size.width > imageSize.width) && (contentRect.size.height < imageSize.height))  || ((imageSize.width > contentRect.size.width && imageSize.height > contentRect.size.height) && (imageSize.width > imageSize.height)))
    {
        imageSize.width = (contentRect.size.height/imageSize.height)*imageSize.width;
        imageSize.height = contentRect.size.height;
    }
    else
    {
        imageNewSize = imageSize;
    }
    return imageNewSize;
}

- (void)setHighlighted:(BOOL)highlighted{  //不显示高亮状态
    
}

@end

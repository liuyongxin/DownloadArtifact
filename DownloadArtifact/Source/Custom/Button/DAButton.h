//
//  DAButton.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/19.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ImageTextAlignmentType)
{
    ImageTextAlignmentTypeDefault,
    ImageTextAlignmentTypeUpDown,
    ImageTextAlignmentTypeLeftRight
};

@interface DAButton : UIButton

@property(nonatomic,assign,readonly)ImageTextAlignmentType imageTextAlignmentType;
@property(nonatomic,assign)CGFloat textImageSpace; //默认5

+ (instancetype)buttonWithFrame:(CGRect)frame ImageTextAlignmentType:(ImageTextAlignmentType )alignmentType;

- (void)addBottomLine:(UIColor *)lineColor lineHeight:(CGFloat )lineHeight;

@end

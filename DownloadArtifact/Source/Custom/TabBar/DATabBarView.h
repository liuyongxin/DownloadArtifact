//
//  DATabBarView.h
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DATabBarItem : UIView

@property(nonatomic,retain)NSValue* iconSize;
@property(nonatomic,assign)NSString *title;
@property(nonatomic,retain)UIImage *icon;
@property(nonatomic,retain)UIImage *selectedIcon;
@property(nonatomic,retain)UIImage *bgImage;
@property(nonatomic,retain)UIImage *selectedBgImage;
@property(nonatomic,retain)UIColor *labelTitleColor;
@property(nonatomic,retain)UIColor *labelTitleSelectedColor;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)BOOL notice;
@property(nonatomic,readonly)UIButton *handleBtn;
@property(nonatomic,readonly)UIImageView *iconView;
@property(nonatomic,readonly)UILabel *itemLabel;
@property (nonatomic, assign)CGFloat fontSize;

-(void)setupView;
-(void)updateIcon;
-(void)reload;

@end

@protocol DATabBarViewDelegate;
@interface DATabBarView : UIView

@property(nonatomic,retain)   NSArray             *items;
@property(nonatomic,retain)   NSArray             *titles;

@property(nonatomic,readonly)UIImageView *backgroundImageView;
@property(nonatomic,readonly) NSUInteger selectedItemIndex;
@property(nonatomic,retain) UIImage *backgroundImage;
@property(nonatomic,retain) NSMutableArray * tabItems;
@property(nonatomic,assign) id<DATabBarViewDelegate> delegate;
@property(nonatomic,copy)void(^selectedTabBarItemAction)(DATabBarView *tabBarView,NSInteger index);

-(void)selectTabBarIndex:(NSUInteger)idx;
-(void)selectTabBarIndexWithoutEvents:(NSUInteger)idx;
-(instancetype)initWithFrame:(CGRect)frame withCommonTabBarItems:(NSArray*)items;
-(void)setNoticeTipHidden:(BOOL)isHide forTabBarItemIndex:(NSUInteger)idx; //设置显示红点

@end

@protocol DATabBarViewDelegate <NSObject>

-(void)tabBar:(DATabBarView*)tabbar tabItemDidSelectedWithIndex:(NSUInteger)idx;

@end

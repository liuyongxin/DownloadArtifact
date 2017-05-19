//
//  DATabBarView.m
//  DownloadArtifact
//
//  Created by DZH_Louis on 2017/5/16.
//  Copyright © 2017年 DZH_Louis. All rights reserved.
//

#import "DATabBarView.h"
@interface DATabBarItem (){
    UILabel *_labeltitle;
    UIImageView *_iconView;
    UIImageView *_selectedIconView;
    UIImageView *_bgImageView;
    UIButton *_handleBtn;
}

@end

@implementation DATabBarItem

-(void)setupView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _bgImageView = [[UIImageView alloc]initWithImage:_bgImage highlightedImage:_selectedBgImage];
    _bgImageView.frame = self.bounds;
    [self addSubview:_bgImageView];
    
    _labelTitleColor = _labelTitleColor ? _labelTitleColor :[UIColor whiteColor];
    _labelTitleSelectedColor = _labelTitleSelectedColor ? _labelTitleSelectedColor : [UIColor whiteColor];
    _labeltitle = [UILabel labelWithText:_title fontSize:self.fontSize color:_labelTitleColor];
    _labeltitle.textColor = _labelTitleColor;
    _labeltitle.centerX = self.sizeWidth / 2;
    if (_icon){
        _labeltitle.originY = self.sizeHeight - 4 - _labeltitle.sizeHeight;
    }
    else{
        _labeltitle.originY = (self.sizeHeight - _labeltitle.sizeHeight) * .5;
    }
    [self addSubview:_labeltitle];
    
    _iconView = [[UIImageView alloc]initWithImage:_icon highlightedImage:_selectedIcon];
    if (self.iconSize) {
        _iconView.sizeWH = [self.iconSize CGSizeValue];
    }else{
        _iconView.sizeWH = CGSizeMake(25, 25);
    }
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.centerX = self.sizeWidth / 2;
    _iconView.originY = 5;
    [self addSubview:_iconView];
    
    _handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _handleBtn.frame = self.bounds;
    [self addSubview:_handleBtn];
}

- (void)setBackView
{
    _handleBtn.sizeWidth = self.sizeWidth;
    _labeltitle.sizeWidth = self.sizeWidth;
    _labeltitle.originX = self.sizeWidth/2-17;
    _labeltitle.sizeHeight = self.sizeHeight;
    _labeltitle.centerY = self.sizeHeight/2;
    _labeltitle.font = [UIFont systemFontOfSize:16];
    
    _iconView.centerY = self.sizeHeight/2;
    _iconView.originX = self.sizeWidth/3-17;
    
    _selectedIconView.originX = _iconView.originX;
    _selectedIconView.centerY = _iconView.centerY;
    _bgImageView.sizeWidth = self.sizeWidth;
    _bgImageView.originY=2;
    _bgImageView.backgroundColor = [UIColor grayColor];
}

-(void)layoutSubviews
{
    [self updateSubViews];
}

- (void)updateSubViews
{
    _handleBtn.frame = self.bounds;
    _labeltitle.centerX = self.sizeWidth/2;
    _bgImageView.frame = self.bounds;
    _iconView.centerX = self.sizeWidth/2;
}

- (CGFloat)fontSize
{
    return _fontSize == 0 ? 11. : _fontSize;
}


-(void)updateIcon
{
    [_iconView setImage:_icon];
    [_iconView setHighlightedImage:_selectedIcon];
    
    if (_selected) {
        self.selected = !_selected;
        self.selected = !_selected;
    }else{
        self.selected = _selected;
    }
    
    [_iconView setNeedsDisplay];
}

-(void)reload
{
    _bgImageView.image                  = _bgImage;
    _bgImageView.highlightedImage       = _selectedBgImage;
    if (_selected)
    {
        self.selected                   = !_selected;//更改一下状态，防止不选中时不刷新图片
        self.selected                   = !_selected;
    }
    else
    {
        self.selected                   = _selected;
    }
}

-(UIImageView *)iconView
{
    return _iconView;
}

-(UILabel *)itemLabel
{
    return _labeltitle;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    _bgImageView.highlighted = selected;
    _iconView.highlighted = selected;
    if (selected) {
        _labeltitle.textColor = _labelTitleSelectedColor;
    }else{
        _labeltitle.textColor = _labelTitleColor;
    }
}

@end

#pragma mark -- DATabBarView
@interface DATabBarView (){
    NSInteger _itemCount;
    UIImageView *_backgroundImageView;
    NSUInteger _selectedTabItemIndex;
}
@end

@implementation DATabBarView

-(instancetype)initWithFrame:(CGRect)frame withCommonTabBarItems:(NSArray*)items
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemCount = items.count;
        CGFloat pos = 0;
        self.tabItems = [NSMutableArray arrayWithArray:items];
        for (int i = 0 ; i < _itemCount; i++) {
            DATabBarItem *it = _tabItems[i];
            __weak typeof(self) weak = self;
            [it.handleBtn bindTouchEvent:UIControlEventTouchDown Callback:^(UIControl *sv) {
                [weak handleTabbarItemPressedWithIndex:i];
            }];
            if (i==0) {
                it.selected = YES;
            }
            it.originX = pos;
            pos += it.sizeWidth;
            [self addSubview:it];
        }
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self insertSubview:_backgroundImageView atIndex:0];
    }
    return self;
}

-(void)setNoticeTipHidden:(BOOL)isHide forTabBarItemIndex:(NSUInteger)idx
{
    DATabBarItem *it = [_tabItems objectAtIndex:idx];
    it.redNoticePoint.hidden = isHide;
}

-(void)handleTabbarItemPressedWithIndex:(NSUInteger)idx
{
    _selectedTabItemIndex = idx;
    for (int i = 0; i<_tabItems.count; i++) {
        DATabBarItem *itemV = [self.tabItems objectAtIndex:i];
        itemV.selected = i == _selectedTabItemIndex;
    }
    BOOL isUseBlock = NO;
    if (self.selectedTabBarItemAction) {
        isUseBlock = YES;
        self.selectedTabBarItemAction(self, _selectedTabItemIndex);
    }
    if (!isUseBlock && self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tabBar:tabItemDidSelectedWithIndex:)]) {
            [self.delegate tabBar:self tabItemDidSelectedWithIndex:_selectedTabItemIndex];
        }
    }
}

-(void)selectTabBarIndex:(NSUInteger)idx
{
    if (_tabItems.count > idx) {
        [self handleTabbarItemPressedWithIndex:idx];
    }
}

-(void)selectTabBarIndexWithoutEvents:(NSUInteger)idx
{
    _selectedTabItemIndex = idx;
    for (int i = 0; i<_tabItems.count; i++) {
        DATabBarItem *itemV = [self.tabItems objectAtIndex:i];
        itemV.selected = i == _selectedTabItemIndex;
    }
}

-(NSUInteger)selectedItemIndex
{
    return _selectedTabItemIndex;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [_backgroundImageView setImage:backgroundImage];
}

@end

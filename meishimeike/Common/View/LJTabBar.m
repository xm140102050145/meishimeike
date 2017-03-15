//
//  LJTabBar.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJTabBar.h"

@implementation LJTabBar

#pragma mark--懒加载发布按钮
- (UIButton*)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        publishButton.backgroundColor = [UIColor redColor];
        [publishButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton=publishButton;
    }
    return _publishButton;
}

#pragma mark--初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark--布局控件
- (void)layoutSubviews {
    [super layoutSubviews];
    /**** 按钮的尺寸 ****/
    CGFloat buttonW = self.lj_width / 5;
    CGFloat buttonH = self.lj_height;
    /**** 设置所有UITabBarButton的frame ****/
    CGFloat TabBarBtnY = 0;
    // 按钮索引
    int TabBarBtnIndex = 0;
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        //设置控件frame
        CGFloat TabBarBtnX = TabBarBtnIndex*buttonW;
        //让tabBar上第一个控件选中状态
        if (TabBarBtnX == 0) {
            UIButton *item = (UIButton *)subview;
            item.selected = YES;
        }
        //为中间的发布按钮空一个位置
        if (TabBarBtnIndex>=2) {
            TabBarBtnX += buttonW;
        }
        subview.frame = CGRectMake(TabBarBtnX, TabBarBtnY, buttonW, buttonH);
        TabBarBtnIndex++;
    }
    /**** 设置中间的发布按钮的frame ****/
    self.publishButton.lj_width = buttonW;
    self.publishButton.lj_height = buttonH;
    self.publishButton.lj_x = 2*buttonW;
    self.publishButton.lj_y = 0;
}

#pragma mark--发布
- (void)publishClick {
    LJLogFunc
}
@end

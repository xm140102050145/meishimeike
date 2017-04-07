//
//  LJTabBar.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJTabBar.h"
#import "LJBaseNavigationController.h"
#import <AVFoundation/AVFoundation.h>

@implementation LJTabBar

#pragma mark--懒加载发布按钮
- (UIButton*)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"home_add_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"home_add_icon"] forState:UIControlStateSelected];
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
        CGFloat TabBarBtnX = TabBarBtnIndex * buttonW;
        
        UIButton *item = (UIButton *)subview;
        [item addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];  //点击某个按钮实现的事件
        
        //让tabBar上第一个控件选中状态
        if (TabBarBtnX == 0) {
            item.selected = YES;
        }
        //为中间的发布按钮空一个位置
        if (TabBarBtnIndex >= 2) {
            TabBarBtnX += buttonW;
        }
        subview.frame = CGRectMake(TabBarBtnX, TabBarBtnY, buttonW, buttonH);
        TabBarBtnIndex++;
    }
    /**** 设置中间的发布按钮的frame ****/
    self.publishButton.lj_width = buttonW;
    self.publishButton.lj_height = buttonH;
    self.publishButton.lj_x = 2 * buttonW;
    self.publishButton.lj_y = - buttonH / 2 + 10;
}

#pragma mark--发布
- (void)publishClick {
    UIViewController *vc = [NSClassFromString(@"LJPublishViewController") new];
    vc.title = @"发布教程";
    LJBaseNavigationController *baseNavigation = [[LJBaseNavigationController alloc] initWithRootViewController:vc];
    baseNavigation.view.frame = LJwindow.bounds;
    if (self.publishView) {
        self.publishView(baseNavigation);
    }
    
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.3,@0.9,@1.35,@0.95,@1.02,@1.0];
            animation.duration = 1;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
    [self playSoundWithSoundName:@"7142.wav"];
}

- (void)playSoundWithSoundName:(NSString *)soundName {
    //定义soundID，并先赋值为0
    SystemSoundID soundID = 0;
    
    //先从字典中取出soundID
    soundID = [self.soundIDs[soundName] unsignedIntValue];
    
    //如果从字典获取不到soundName对应的soundID，就创建soundID
    if (soundID == 0) {
        //加载音效的URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        
        //将音效的URL桥接为CFURLRef类型的URL
        CFURLRef urlRef = (__bridge CFURLRef)(url);
        
        //根据音效URL生成对应的SystemSoundID(传soundID的地址，生成之后会根据地址找到它，并赋值)
        AudioServicesCreateSystemSoundID(urlRef, &soundID);
        
        //将这个soundID保存到字典
        [self.soundIDs setValue:@(soundID) forKey:soundName];
    }
    
    //播放音效
    AudioServicesPlaySystemSound(soundID);
}

@end

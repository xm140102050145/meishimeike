//
//  DLVideoPlayView.h
//  DLVideoPlayView
//
//  Created by zhenglong duan on 22/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/*** 手势类型 ***/
typedef NS_ENUM(NSInteger, TouchPlayerViewMode) {
    TouchPlayerViewModeTap, // 轻触
    TouchPlayerViewModeSwipingHorizontal, // 水平滑动
    TouchPlayerViewModeSwipingVertical, // 上下滑动
};

typedef void (^backframe)(UIView * view);// 返回当前播放的view

@interface DLVideoPlayView : UIView {
    TouchPlayerViewMode _TouchPlayerViewMode; //手势类型
}

@property (nonatomic,strong) UILabel *titleLabel; //标题
@property (nonatomic,strong) UIButton *collectBtn; //收藏

#pragma mark --为了显示预览图
- (void)playVideoWithURL;

#pragma mark -- 播放地址
@property (nonatomic,strong) NSURL *URLStr;
#pragma mark -- 让持有者控制自己的frame
@property (nonatomic,copy) backframe viewbackframe ;
@end

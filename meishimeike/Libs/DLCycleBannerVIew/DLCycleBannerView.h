//
//  DLCycleBannerVIew.h
//  DLCycleBannerVIew
//
//  Created by zhenglong duan on 13/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*** PageControl的位置 ***/
typedef NS_ENUM(NSInteger, DLCyleBannerViewPageControlAliment) {
    DLCyleBannerViewPageControlAlimentRight,  //默认在右边
    DLCyleBannerViewPageControlAlimentCenter,
};
/*** PageControl的样式 ***/
typedef NS_ENUM(NSInteger, DLCyleBannerViewPageControlStyle) {
    DLCyleBannerViewPageControlStyleClassic, //系统经典样式
    DLCyleBannerViewPageControlStyleNone     //不显示
};

@class DLCycleBannerView;  //仅仅是声明一个类名，并不会包含类的完整声明
@protocol DLCycleBannerViewDelegate <NSObject>
#pragma mark -- 代理方法
/*** 当选中某一个Item时要进行的点击事件操作 ***/
- (void)cycleBannerView:(DLCycleBannerView *)cycleBannerView didSelectItemAtIndex:(NSInteger)Index;

- (void)indexOnPageControl:(NSInteger)index;
@end

@interface DLCycleBannerView : UIView

#pragma mark -- 数据源接口
/*** 本地图片数组 ***/
@property (nonatomic,strong) NSArray *localiztionImagesArray;
/*** 网络 URL string 数组 ***/
@property (nonatomic,strong) NSArray *URLStringImagesArray;
/*** 每张图片对应显示的文字数组 ***/
//@property (nonatomic,strong) NSArray *titleArray;
/*** 索引 ***/
@property (nonatomic,assign) NSInteger index;

#pragma mark -- 滚动控制接口
/*** 滚动时间间隔，默认是2s ***/
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;
/*** 是否无限循环，默认yes ***/
@property (nonatomic,assign) BOOL infiniteLoop;
/*** 是否自动滚动，默认yes ***/
@property (nonatomic,assign) BOOL autoScroll;
/*** 代理属性 ***/
@property (nonatomic,weak) id <DLCycleBannerViewDelegate> delegate;

#pragma mark -- 自定义样式接口
/*** 是否显示分页控件,默认是yes ***/
@property (nonatomic,assign) BOOL isShowPageControl;
/*** 分页控件PageControl的样式，默认是系统经典样式 ***/
@property (nonatomic,assign) DLCyleBannerViewPageControlStyle pageControlStyle;
/*** 分页控件PageControl的位置 ***/
@property (nonatomic,assign) DLCyleBannerViewPageControlAliment pageControlAliment;
/*** 分页控件的大小 ***/
//@property (nonatomic,assign) CGSize pageControlSize;
/*** 分页控件的颜色 ***/
@property (nonatomic,strong) UIColor *pageControlColor;
/*** 占位图，用于未加载到图片时 ***/
@property (nonatomic,strong) UIImage *placeholderImage;
/*** 每张图片对应文字Label的属性 ***/
//@property (nonatomic, strong) UIColor *titleLabelTextColor;
//@property (nonatomic, strong) UIFont  *titleLabelTextFont;
//@property (nonatomic, assign) CGFloat titleLabelHeight;

#pragma mark -- 清除缓存接口
- (void)clearCache;
@end

//
//  LJzhongcanViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJzhongcanViewController.h"
#import "LJLuViewController.h"
#import "LJSuViewController.h"
#import "LJZheViewController.h"
#import "LJChuanViewController.h"
#import "LJYuViewController.h"

@interface LJzhongcanViewController ()<UIScrollViewDelegate>
/*** 整个背景ScrollView ***/
@property (strong, nonatomic) UIScrollView *ScrollView;
/*当前选中的标题按钮*/
@property (strong, nonatomic) UIButton *selectedTitleButton;
/*指示器*/
@property (strong, nonatomic) UIView *indicatorView;
/*标题栏*/
@property (strong, nonatomic) UIView *TitleView;
/*** 标题数组 ***/
@property (nonatomic,strong) NSMutableArray *titleArray;
@end

@implementation LJzhongcanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];                 // 1.加载数据
    [self addChildVc];
    [self setScrollviewBannerAttribute];// 2.设置ScrollView和Banner属性设置
    [self setUpTitleView];           // 3.设置标题View
    [self addChildVcToScrollView];  //4.设置默认子视图
}


#pragma mark --加载数据
- (void)loadData {
    self.titleArray = [NSMutableArray arrayWithObjects:@"鲁菜",@"豫菜",@"浙菜",@"苏菜",@"川菜", nil];
    
}

- (void)addChildVc {
    LJLuViewController *lu = [[LJLuViewController alloc] init];
    [self addChildViewController:lu];
    LJYuViewController *yu = [[LJYuViewController alloc] init];
    [self addChildViewController:yu];
    LJZheViewController *zhe = [[LJZheViewController alloc] init];
    [self addChildViewController:zhe];
    LJSuViewController *su = [[LJSuViewController alloc] init];
    [self addChildViewController:su];
    LJChuanViewController *chuan = [[LJChuanViewController alloc] init];
    [self addChildViewController:chuan];
}

#pragma mark-ScrollView和Banner属性设置
- (void)setScrollviewBannerAttribute{
    self.automaticallyAdjustsScrollViewInsets = NO;       //1.避免scrollView自动预留64px空间
    self.TitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.lj_width, 36)];
    self.TitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TitleView];
    //4.设置背景ScrollView的属性
    self.ScrollView = [[UIScrollView alloc] init];
    self.ScrollView.backgroundColor = LJCommonBgColor;
    self.ScrollView.frame = CGRectMake(0, self.TitleView.lj_bottom, SCREEN_WIDTH, self.view.lj_height - 64 - self.TitleView.lj_height);
    self.ScrollView.pagingEnabled = YES;
    self.ScrollView.showsHorizontalScrollIndicator = NO;
    self.ScrollView.showsVerticalScrollIndicator = NO;
    self.ScrollView.contentSize = CGSizeMake(self.view.lj_width * self.titleArray.count, 0);
    self.ScrollView.delegate = self;
    [self.view addSubview:self.ScrollView];
}

#pragma mark --设置标题栏
- (void)setUpTitleView {
    //1.标题
    NSUInteger count = self.titleArray.count;
    CGFloat titleButtonW = SCREEN_WIDTH / self.titleArray.count;
    CGFloat titleButtonH = self.TitleView.lj_height;
    //3.创建Button
    for (NSUInteger i = 0; i < count; i++) {
        UIButton* titleButton = [[UIButton alloc] initWithFrame:CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH)];
        [titleButton setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [titleButton.titleLabel setFont:LJFontSize16];
        [titleButton setTitleColor:LJFontColor39 forState:UIControlStateNormal];
        [titleButton setTitleColor:LJTheMeColor forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.tag = i;
        [self.TitleView addSubview:titleButton];
    }
    //4.找出第一个按钮
    UIButton *firstTitleButton = self.TitleView.subviews.firstObject;
    //5.创建底部指示器
    self.indicatorView = [[UIView alloc]init];
    self.indicatorView.backgroundColor = LJTheMeColor;
    self.indicatorView.lj_height = 2;
    self.indicatorView.lj_y =self.TitleView.lj_height - self.indicatorView.lj_height;
    [self.TitleView addSubview:self.indicatorView];
    //6.立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    self.indicatorView.lj_width = firstTitleButton.titleLabel.lj_width;
    self.indicatorView.lj_centerX = firstTitleButton.lj_centerX;
    //7.默认选择第一个按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
}

#pragma mark --点击事件
//1.标签栏的点击事件
- (void)titleButtonClick:(UIButton *)titleButton {
    //1.按钮状态控制、设置字体大小
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    //2.指示器跟随滚动
    [UIView animateWithDuration:0.06 animations:^{
        self.indicatorView.lj_width=titleButton.titleLabel.lj_width;
        self.indicatorView.lj_centerX=titleButton.lj_centerX;
    }];
    //3.ScrollView跟随滚动
    CGPoint offset = self.ScrollView.contentOffset;
    offset.x = titleButton.tag * self.ScrollView.lj_width;
    [self.ScrollView setContentOffset:offset animated:YES];
}

#pragma mark-添加子控制器到ScrollView上
- (void)addChildVcToScrollView {
    //1.子控制器的索引
    int index = self.ScrollView.contentOffset.x / self.ScrollView.lj_width;
    UIViewController *ChildreView = self.childViewControllers[index];
    if ([ChildreView isViewLoaded]) return;
    ChildreView.view.frame = self.ScrollView.bounds;
    [self.ScrollView addSubview:ChildreView.view];
}


#pragma mark - <UIScrollViewDelegate>
///** 在scrollView滚动动画结束时, 就会调用这个方法
// 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildVcToScrollView];
}
// 在scrollView滚动动画结束时, 就会调用这个方法
// 前提: 人为拖拽scrollView产生的滚动动画
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 选中点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.lj_width;
    UIButton *titleButton = self.TitleView.subviews[index];
    [self titleButtonClick:titleButton];
    [self addChildVcToScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

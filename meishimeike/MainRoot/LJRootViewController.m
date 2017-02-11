//
//  LJRootViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 20/12/2016.
//  Copyright © 2016 zhenglong duan. All rights reserved.
//

#import "LJRootViewController.h"
#import "LJBaseNavigationController.h"
#import "LJTabBar.h"
#define kClassKey @"RootVC"
#define kTitleKey @"title"
#define kImageKey @"imageName"
#define kSelImageKey @"selectdImageName"
@interface LJRootViewController ()

@end

@implementation LJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*** 子控制器  ***/
    NSArray *childVCArray = @[@{kClassKey:@"LJHomeViewController",
                                kTitleKey:@"首页",
                                kImageKey:@"",
                                kSelImageKey:@""},
                              @{kClassKey:@"LJInfoViewController",
                                kTitleKey:@"资讯",
                                kImageKey:@"",
                                kSelImageKey:@""},
                              @{kClassKey:@"LJFoodCircleViewController",
                                kTitleKey:@"美食圈",
                                kImageKey:@"",
                                kSelImageKey:@""},
                              @{kClassKey:@"LJMeViewController",
                                kTitleKey:@"我的",
                                kImageKey:@"",
                                kSelImageKey:@""}];
    [childVCArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *Vc = [NSClassFromString(dic[kClassKey]) new];
        Vc.title = dic[kTitleKey];
        LJBaseNavigationController *nav = [[LJBaseNavigationController alloc] initWithRootViewController:Vc];
        UITabBarItem *BarItem = nav.tabBarItem;
        BarItem.title = dic[kTitleKey];
        BarItem.image = [UIImage imageNamed:dic[kImageKey]];
        BarItem.selectedImage = [[UIImage imageNamed:dic[kSelImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //防止图标渲染
        [self addChildViewController:nav];
    }];
    [self setUpTabBar]; //一定是先更换自定义的tabBar 再进行文字属性统一
    [self UnifyText];
    self.selectedIndex = 0;   
}

#pragma mark--统一文字属性
- (void)UnifyText {
    /*** 正常状态  ***/
    NSMutableDictionary *textNormal = [NSMutableDictionary dictionary];
    textNormal[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    textNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    /*** 选中状态  ***/
    NSMutableDictionary *textSelect = [NSMutableDictionary dictionary];
    textSelect[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    textSelect[NSForegroundColorAttributeName] = [UIColor redColor];
    /*** 用appearance统一文字属性  ***/
    self.tabBarItem = [UITabBarItem appearance];
    [self.tabBarItem setTitleTextAttributes:textNormal forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:textSelect forState:UIControlStateSelected];
}

#pragma mark--更换TabBar
- (void)setUpTabBar {
    [self setValue:[[LJTabBar alloc] init] forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

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
                                kImageKey:@"home_icon",
                                kSelImageKey:@"home_selected_icon"},
                              @{kClassKey:@"LJInfoViewController",
                                kTitleKey:@"厨艺",
                                kImageKey:@"home_cook_icon",
                                kSelImageKey:@"home_cook_selected_icon"},
                              @{kClassKey:@"LJFoodCircleViewController",
                                kTitleKey:@"圈儿",
                                kImageKey:@"home_share_icon",
                                kSelImageKey:@"home_share_selected_icon"},
                              @{kClassKey:@"LJMeViewController",
                                kTitleKey:@"我的",
                                kImageKey:@"home_me_icon",
                                kSelImageKey:@"home_me_selected_icon"}];
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
}

#pragma mark--统一文字属性
- (void)UnifyText {
    /*** 用appearance统一文字属性  ***/
    self.tabBarItem = [UITabBarItem appearance];
    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:LJFontSize12,NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:LJFontSize12,NSForegroundColorAttributeName:LJTheMeColor} forState:UIControlStateSelected];
}

#pragma mark--更换TabBar
- (void)setUpTabBar {//
    LJTabBar *tabbar = [[LJTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    self.selectedIndex = 0;
    UIViewController *selectView = self.selectedViewController;
    tabbar.publishView = ^(UIViewController *publishView) {
        [selectView presentViewController:publishView animated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

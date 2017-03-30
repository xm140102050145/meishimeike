//
//  LJAddressSelectedViewController.m
//  xianchufang
//
//  Created by zhenglong duan on 27/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJAddressSelectedViewController.h"
@interface LJAddressSelectedViewController ()
@property(nonatomic,strong)UITableView *LocationView;

@property (nonatomic,strong) UILabel *currentLabel;
@end

@implementation LJAddressSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"附近地址";
    [self setChildrenLayout];
}

#pragma mark --初始化子控件
- (void)setChildrenLayout {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

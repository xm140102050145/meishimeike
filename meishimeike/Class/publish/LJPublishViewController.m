//
//  LJPublishViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 28/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//
//$name=$_POST["name"];
//$brief=$_POST["brief"];
//$taste=$_POST["taste"];
//$time=$_POST["time"];
//$crowd=$_POST["crowd"];
//$pay=$_POST["pay"];
//$kind=$_POST["kind"];
//$classify=$_POST["classify"];
//$material=$_POST["material"];
//$tapy=$_POST["tapy"];
//$userid=$_POST["userid"];
//$stepconent=$_POST["stepconent"];

#import "LJPublishViewController.h"

@interface LJPublishViewController ()

@end

@implementation LJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LJCommonBgColor;
    [self addBackBtn];
}

#pragma mark- 返回键
- (void)addBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

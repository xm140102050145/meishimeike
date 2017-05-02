//
//  LJPublishViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 28/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJPublishViewController.h"
#import "UIBarButtonItem+LJExtension.h"
#import "LJNextPublishViewController.h"
@interface LJPublishViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UITextField *textField1;

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) NSString *kind;
@end

@implementation LJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LJCommonBgColor;
    [self addBtn];
    
    [self addMenuName]; //菜谱名称
}

#pragma mark- 返回键、下一步
- (void)addBtn {
    //
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"back_icon" highImage:nil target:self action:@selector(backClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithText:@"继续" hightext:nil color:LJTheMeColor highColor:nil target:self action:@selector(nextClick)];
}

- (void)addMenuName {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH * 2 / 3, 50)];
    textField.lj_centerX = SCREEN_WIDTH / 2;
    textField.placeholder = @"添加菜谱名称";
    textField.font = [UIFont systemFontOfSize:25 weight:2];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textColor = LJTheMeColor;
    textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textField];
    
    [textField becomeFirstResponder];
    
    self.textField = textField;
    
    [self.view addSubview:[UIView setLineViewAtY:textField.lj_bottom + 15]]; //下画线
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, textField.lj_bottom + 30, SCREEN_WIDTH / 3, 50)];
    textField1.lj_centerX = SCREEN_WIDTH / 2;
    textField1.placeholder = @"美食类别";
    textField1.font = [UIFont systemFontOfSize:25 weight:2];
    textField1.borderStyle = UITextBorderStyleNone;
    textField1.textColor = LJTheMeColor;
    textField1.textAlignment = NSTextAlignmentCenter;
    textField1.userInteractionEnabled = NO;
    [self.view addSubview:textField1];
    self.textField1 = textField1;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(textField1.lj_right, 0, 20, 20)];
    btn.lj_centerY = textField1.lj_centerY;
    btn.backgroundColor = LJRandomColor;
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectCategroyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.view addSubview:[UIView setLineViewAtY:textField1.lj_bottom + 15]]; //下画线
}

- (void)selectCategroyClick {
    
    [self.textField resignFirstResponder];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2 - 15, SCREEN_HEIGHT / 3)];
    tableView.lj_centerX = SCREEN_WIDTH / 2;
    tableView.lj_centerY = SCREEN_HEIGHT / 2;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = LJCommonBgColor;
    tableView.showsVerticalScrollIndicator = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"kind.plist" ofType:nil];
    self.dataArray = [NSArray arrayWithContentsOfFile:path];
    
    UIView *view = [[UIView alloc] initWithFrame:LJwindow.bounds];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [LJwindow addSubview:view];
    self.bgView = view;
    
    [view addSubview:tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataArray[indexPath.row];
    self.textField1.text = dic[@"name"];
    self.kind = dic[@"kind"];
    [self.bgView removeFromSuperview];
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextClick {
    LJNextPublishViewController *nextView = [[LJNextPublishViewController alloc] init];
    nextView.cateName = self.textField.text;
    nextView.cateKind = self.kind;
    [self.navigationController pushViewController:nextView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

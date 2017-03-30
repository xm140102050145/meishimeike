//
//  LJMyCollectDetailViewController.m
//  xianchufang
//
//  Created by zhenglong duan on 22/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJMyCollectDetailViewController.h"
#import "LJMyCollectDetailTableViewCell.h"
#import "UIBarButtonItem+LJExtension.h"
#import "LJcateStartViewController.h"

@interface LJMyCollectDetailViewController ()
/*** 底部标签 ***/
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation LJMyCollectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    self.tableView.lj_y = 14;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LJMyCollectDetailTableViewCell class] forCellReuseIdentifier:@"LJMyCollectDetailTableViewCell"];
    [self.view addSubview:self.tableView];
    NSDictionary *dic = @{@"userid":@"1"};//USERDEFINE.currentUser.user_id
    [AFNetworkingAPI getWithPath:Mycollect Params:dic requrieDataBack:^(id  _Nonnull data) {
        self.dataArray = data;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJMyCollectDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJMyCollectDetailTableViewCell"];
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.dic = dic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataArray[indexPath.row];
    LJcateStartViewController *learn = [[LJcateStartViewController alloc] init];
    learn.cateid = dic[@"cate_id"];
    [self.navigationController pushViewController:learn animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

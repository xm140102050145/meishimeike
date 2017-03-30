//
//  LJFoodCircleViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJFoodCircleViewController.h"
#import "LJSuosuoTableViewCell.h"
@interface LJFoodCircleViewController ()

@end

@implementation LJFoodCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.lj_height = SCREEN_HEIGHT - 113;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LJSuosuoTableViewCell class] forCellReuseIdentifier:@"LJSuosuoTableViewCell"];
    [AFNetworkingAPI getWithPath:Loadsuosuo Params:nil requrieDataBack:^(id  _Nonnull data) {
        self.dataArray = [LJSuoSuoModel mj_objectArrayWithKeyValuesArray:data];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJSuoSuoModel *suosuoModel = self.dataArray[indexPath.row];
    return suosuoModel.cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJSuosuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJSuosuoTableViewCell"];
    cell.suosuoModel = self.dataArray[indexPath.row];
    cell.cell = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backCellIndex = ^(NSInteger cell) {
        
    };
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  LJcateStartViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 21/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJcateStartViewController.h"
#import "LJcateStartTableViewCell.h"
@interface LJcateStartViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LJcateStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"烹饪";
    [self.tableView registerNib:[UINib nibWithNibName:@"LJcateStartTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJcateStartTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJcateStartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJcateStartTableViewCell"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)StatBtn:(UIButton *)sender {
    NSLog(@"开始了");
}


@end

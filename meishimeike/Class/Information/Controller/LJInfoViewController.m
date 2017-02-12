//
//  LJInfoViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJInfoViewController.h"
#import "LJNewsTableViewCell.h"
@interface LJInfoViewController ()<UITableViewDelegate,UITableViewDataSource,LJDataDelegate>

@property (nonatomic,strong) UITableView *newsTableView;
@property (nonatomic,strong) UIScrollView *newsScrollView;
@property (nonatomic,strong) NSArray *newsArr;
@property (nonatomic,strong) LJData *Data;
@end

@implementation LJInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Data];
    
}
/*** 懒加载 ***/
- (UIScrollView *)newsScrollView {
    if (!_newsScrollView) {
        _newsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _newsScrollView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_newsScrollView];
    }
    return _newsScrollView;
}

- (UITableView *)newsTableView {
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.newsScrollView.lj_bottom, SCREEN_WIDTH, SCREEN_HEIGHT-249) style:UITableViewStylePlain];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
        [self.view addSubview:_newsTableView];
    }
    return _newsTableView;
}

- (NSArray *)newsArr {
    if (!_newsArr) {
        _newsArr = [NSArray array];
    }
    return _newsArr;
}

- (LJData *)Data {
    if (!_Data) {
        _Data = [[LJData alloc] init];
        _Data.delegate = self;
        [_Data getDataForParameter:nil url:[NSString stringWithFormat:@"%@?newsid=0",News]];
    }
    return _Data;
}

/*** LJData代理方法 ***/
- (void)data:(NSMutableArray *)array {
    self.newsArr = array;
    [self.newsTableView reloadData];
}

/*** UITableView代理方法 ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[LJNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

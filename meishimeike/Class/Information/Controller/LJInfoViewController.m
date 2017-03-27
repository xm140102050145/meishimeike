//
//  LJInfoViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJInfoViewController.h"
#import "LJNewsTableViewCell.h"
#import "LJNewsModel.h"
#import "DLCycleBannerView.h"

@interface LJInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *newsTableView;
@property (nonatomic,strong) NSMutableArray *newsArr;
@end

@implementation LJInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self newsTableView];
    [self CycleBannerView];
    [AFNetworkingAPI getWithPath:Videocate Params:nil requrieDataBack:^(id  _Nonnull data) {
        NSArray *arr = [LJNewsModel mj_objectArrayWithKeyValuesArray:data];
        for (int i = 0; i <arr.count; i++) {
            LJNewsModel *model = arr[i];
            if ((model.cate_stepvideo.length > 0)) {
                [self.newsArr addObject:model];
            }
        }
        [self.newsTableView reloadData];
    }];
}

- (void)CycleBannerView {
    NSArray *imagesArray = @[@"z3@2x",@"z4@2x",@"z2@2x",@"z1@2x"];
    // 创建不带标题的图片轮播器
    DLCycleBannerView *cycleBannerView = [[DLCycleBannerView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 136)];
    cycleBannerView.localiztionImagesArray = imagesArray;
    cycleBannerView.placeholderImage = [UIImage imageNamed:@"homepagebannerplaceholder"];
    [self.view addSubview:cycleBannerView];
}

- (UITableView *)newsTableView {
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-249) style:UITableViewStylePlain];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
        [self.view addSubview:_newsTableView];
         _newsTableView.tableFooterView = [[UIView alloc] init];
    }
    return _newsTableView;
}

- (NSArray *)newsArr {
    if (!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

/*** UITableView代理方法 ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[LJNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.newsModel = self.newsArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc
{
    self.tableView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

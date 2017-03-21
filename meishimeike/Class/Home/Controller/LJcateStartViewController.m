//
//  LJcateStartViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 21/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJcateStartViewController.h"
#import "LJcateStartTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface LJcateStartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSString *cate_tapy; //类型1是图文，2是视频
@property (nonatomic,strong) NSMutableArray *arr; //装食材的数组
@end

@implementation LJcateStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"烹饪";
    self.arr = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LJcateStartTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJcateStartTableViewCell"];
    NSString *url = [NSString stringWithFormat:@"%@/cateid/%@",Requrecate,self.cateid];
    [AFNetworkingAPI getWithPath:url Params:nil requrieDataBack:^(id  _Nonnull data) {
        LJCateModel *cate = [LJCateModel mj_objectWithKeyValues:data];
        NSString *url = [NSString stringWithFormat:@"%@%@",foodimageUrl,cate.cate_bgimage];
        [self.cateImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        NSString *url1 = [NSString stringWithFormat:@"%@%@",headerUrl,cate.user_headimage];
        [self.cateImageSmallView sd_setImageWithURL:[NSURL URLWithString:url1]];
        self.OwnNameLabel.text = cate.user_name;
        self.collectNumLabel.text = [NSString stringWithFormat:@"%@人收藏",cate.cate_collectnum];
        [self.sweetBtn setTitle:cate.cate_taste forState:UIControlStateNormal];
        [self.timeBtn setTitle:cate.cate_time forState:UIControlStateNormal];
        [self.potBtn setTitle:cate.cate_pay forState:UIControlStateNormal];
        [self.peopleBtn setTitle:cate.cate_crowd forState:UIControlStateNormal];
        self.catename.text = cate.cate_name;
        self.cate_tapy = cate.cate_tapy;
        
        //分割
        NSArray *arr = [cate.cate_material componentsSeparatedByString:@"/"];
        for (int i = 0; i < arr.count; i++) {
            NSString *str = arr[i];
            NSArray *array = [str componentsSeparatedByString:@"="];
            NSDictionary *dic = @{@"name":array[0],@"standard":array[1]};
            [self.arr addObject:dic];
        }
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJcateStartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJcateStartTableViewCell"];
    NSDictionary *dic = self.arr[indexPath.row];
    cell.nameLabel.text = dic[@"name"];
    cell.standardLable.text = dic[@"standard"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)StatBtn:(UIButton *)sender {
    //将self.cateid  和  self.cate_tapy 传到下一个界面进行教程获取
    NSLog(@"self.cateid:%@    self.cate_tapy:%@",self.cateid,self.cate_tapy);
}


@end

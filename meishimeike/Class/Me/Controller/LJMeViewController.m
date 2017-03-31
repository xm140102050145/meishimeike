//
//  LJMeViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJMeViewController.h"
#import "LJOrderStatusTableViewCell.h"
#import "LJOrderBaseViewController.h"
@interface LJMeViewController ()
/*** 背景视图 ***/
@property (nonatomic,strong) UIView *backgroundView;
/*** 背景图片 ***/
@property (nonatomic,strong) UIImageView *backgroundImageView;
/*** 用户头像 ***/
@property (nonatomic,strong) UIImageView *headerImageView;
/*** 用户昵称 ***/
@property (nonatomic,strong) UILabel *userNameLabel;
/*** 消息button ***/
@property (nonatomic,strong) UIButton *messageBtn;
@end
/*** 声明cell  ***/
static NSString *const LJOrderStatusCellID = @"LJOrderStatusCell";

@implementation LJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLayoutHeaderImageView];
    [self setNavigationStatus];
}

#pragma mark --懒加载
- (UIView *)backgroundView {
    if (!_backgroundView){
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, spaceEdgeH(240))];
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, spaceEdgeH(240))];
        _backgroundImageView.image = [UIImage imageNamed:@"me_background_icon"];
        _backgroundImageView.userInteractionEnabled = self;
        [self.backgroundView addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        _userNameLabel.text = @"点击头像登陆";
        [_userNameLabel sizeToFit];
        _userNameLabel.textColor = [UIColor whiteColor];
        [self.backgroundImageView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc ] init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headerImageView.backgroundColor = LJRandomColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personInfoSetting)];
        [_headerImageView addGestureRecognizer:tap];
        _headerImageView.userInteractionEnabled = YES;
        [self.backgroundImageView addSubview:_headerImageView];
    }
    return _headerImageView;
}

#pragma mark --个人信息设置
- (void)personInfoSetting {
    if (USERDEFINE.currentUser) {      //用户已登陆，进行个人信息设置
        UIViewController * Vc =[NSClassFromString(@"LJUserInfoViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }else{  //进入登陆界面LJLoginViewController
        UIViewController * Vc =[NSClassFromString(@"LJLoginViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }
}

#pragma mark --设置背景头像位置
- (void)setLayoutHeaderImageView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.backgroundView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*** 注册自定义cell ***/
    [self.tableView registerClass:[LJOrderStatusTableViewCell class] forCellReuseIdentifier:LJOrderStatusCellID];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(70);
        make.centerX.mas_equalTo(self.backgroundView.mas_centerX);
        make.centerY.mas_equalTo(self.backgroundView.mas_centerY).offset(18);
    }];
    self.headerImageView.layer.masksToBounds = YES; //没这句话它圆不起来
    self.headerImageView.layer.cornerRadius = 70 / 2;
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.headerImageView.mas_centerX);
        make.height.mas_equalTo(25);
    }];
}

#pragma mark --导航栏设置 
- (void)setNavigationStatus {
    self.navigationItem.title = @"我的";
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
    /*** 左边消息图标 ***/
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= CGRectMake(0, 13, 50, 50);
    button.tag =1111;
    [button setImage:[UIImage imageNamed:@"tabbar_news_icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.messageBtn =button;
    [self.view addSubview:button];
  
    /*** 右边设置图标 ***/
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame= CGRectMake(0, 15, 50, 50);
    button1.lj_right =self.view.lj_right+5 ;
    [button1 setImage:[UIImage imageNamed:@"tabbar_set_icon"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

#pragma mark --消息触发
- (void)messageBtnClick {
    UIViewController * Vc =[NSClassFromString(@"LJNewsCenterViewController") new];
    [self.navigationController pushViewController:Vc animated:YES];
}

#pragma mark --设置触发
- (void)settingBtnClick {
    UIViewController * Vc =[NSClassFromString(@"LJSettingViewController") new];
    [self.navigationController pushViewController:Vc animated:YES];
}

/*** tableView代理方法 ***/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return spaceEdgeH(45);
        }else{
            return spaceEdgeH(67);
        }
    }else{
        return spaceEdgeH(45);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 &&indexPath.row ==1) {
        /*** 自定义订单cell ***/
        LJOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LJOrderStatusCellID];
        __weak LJMeViewController* weakSelf = self;
        cell.myOrderBlock = ^(NSInteger tag){
            [weakSelf MyOrderStatusClick:tag];
        };
        return cell;
    }else{
        static NSString* cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:LJFontSize15];
        /*** 分割线 ***/
        UIView *CutLine = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
        CutLine.backgroundColor = LJCutLineColor;
        [cell addSubview:CutLine];
        
        if (indexPath.section ==0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"我的订单";
                cell.detailTextLabel.text = @"查看全部订单";
                [cell.detailTextLabel setTextColor:LJFontColor39];
                [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
            }
        }else {
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"me_shoucang_icon"];
                    cell.textLabel.text = @"我的收藏";
                    break;
                case 1:
                    cell.imageView.image = [UIImage imageNamed:@"me_tv_icon"];
                    cell.textLabel.text = @"我的教程";
                    break;
                case 2:
                    cell.imageView.image = [UIImage imageNamed:@"me_contant_icon"];
                    cell.textLabel.text = @"我的关注";
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
}

#pragma mark --查看我的订单状态
- (void)MyOrderStatusClick:(NSInteger)tag {
    if (tag == 0) { //待付款
        UIViewController *Vc = [NSClassFromString(@"LJPayOrderViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (tag == 1){ //待配送
        UIViewController *Vc = [NSClassFromString(@"LJDeliverOreViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (tag == 2){ //待收货
        UIViewController *Vc = [NSClassFromString(@"LJReceiveOrderViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (tag == 3){//退换货
        UIViewController *Vc = [NSClassFromString(@"LJReturnGoodsOrderViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }else if (tag == 4){ //待评价
        UIViewController *Vc = [NSClassFromString(@"LJEvaluateOrderViewController") new];
        [self.navigationController pushViewController:Vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {//全部订单
            UIViewController *Vc = [NSClassFromString(@"LJAllOrderViewController") new];
            [self.navigationController pushViewController:Vc animated:YES];
        }
    }else {
        if (indexPath.row == 0){
            UIViewController *Vc = [NSClassFromString(@"LJMyCollectDetailViewController") new];
            [self.navigationController pushViewController:Vc animated:YES];
        }else if (indexPath.row == 1){  //教程
            UIViewController *Vc = [NSClassFromString(@"LJOnlineServiceViewController") new];
            [self.navigationController pushViewController:Vc animated:YES];
        }else if (indexPath.row == 2){  //关注
            UIViewController *Vc = [NSClassFromString(@"LJCheckUpdateViewController") new];  //关于我们
            [self.navigationController pushViewController:Vc animated:YES];
        }
    }
}

#pragma mark --ScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
        /*** 图片放大 ***/
    CGFloat imageH = self.backgroundView.lj_height;
    CGFloat imageW = SCREEN_WIDTH;
    if (offset_Y < 0) {
        CGFloat totalOffset = imageH + ABS(offset_Y);  //ABS 是整数绝对值
        self.backgroundImageView.frame = CGRectMake(0, offset_Y, imageW, totalOffset);
    }else{
        self.backgroundImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.backgroundView.lj_height);
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*** 将tableView恢复到初始位置 ***/
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    if (USERDEFINE.currentUser) {
        self.userNameLabel.text = USERDEFINE.currentUser.user_name;
        NSString *url = [NSString stringWithFormat:@"%@%@",headerUrl,USERDEFINE.currentUser.user_headimage];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
}
@end

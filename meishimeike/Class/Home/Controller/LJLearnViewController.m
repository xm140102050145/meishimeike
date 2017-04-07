//
//  LJLearnViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJLearnViewController.h"
#import "LJTooltip.h"
@interface LJLearnViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollViewtop;
@property (nonatomic,strong) UIScrollView *scrollViewbottom;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *briefLabel;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *data1Array;

@property (nonatomic,strong) UILabel *stepLabel;
@property (nonatomic,strong) UILabel *textContentLabel;

@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation LJLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.cateName;
    [self load];
    
}


- (void)load {
    NSString *url = [NSString stringWithFormat:@"%@/cateid/%@/tapy/%@",Requrededatil,self.cateid,self.catetype];
    [AFNetworkingAPI getWithPath:url Params:nil requrieDataBack:^(id  _Nonnull data) {
        NSString *strPic = data[@"cate_stepimage"];
        NSString *strSte = data[@"cate_stepconent"];
        self.dataArray = [strPic componentsSeparatedByString:@"/"];
        self.data1Array = [strSte componentsSeparatedByString:@"/"];
        [self baseConfigInfo];
    }];
}

#pragma mark -基本配置
- (void)baseConfigInfo {
    self.view.backgroundColor = LJCommonBgColor;
    self.scrollViewtop = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 74, 250, 140)];
    self.scrollViewtop.lj_centerX = self.view.lj_centerX;
    self.scrollViewtop.contentSize = CGSizeMake(self.dataArray.count * 250, 140);
    self.scrollViewtop.pagingEnabled = YES;
    self.scrollViewtop.delegate = self;
    self.scrollViewtop.showsHorizontalScrollIndicator = NO;
    self.scrollViewtop.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollViewtop];
    
    for (int i = 0; i <self.dataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 250, 0, self.scrollViewtop.lj_width, 140)];
        NSString *url = [NSString stringWithFormat:@"%@%@",foodimageUrl,self.dataArray[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.scrollViewtop addSubview:imageView];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollViewtop.lj_bottom + 20, SCREEN_WIDTH, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    self.userImageView.lj_centerY = bgView.lj_height / 2;
    [self.userImageView setLayerWithCr:20];
    self.userImageView.image = self.userImage;
    [bgView addSubview:self.userImageView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.lj_right + 10, self.userImageView.lj_y, 130, 15)];
    self.userNameLabel.textColor = LJFontColor39;
    self.userNameLabel.font = LJFontSize14;
    self.userNameLabel.text = self.userName;
    [bgView addSubview:self.userNameLabel];
    self.briefLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.lj_right + 10, self.userNameLabel.lj_bottom + 15, 130, 13)];
    self.briefLabel.textColor = LJFontColor61;
    self.briefLabel.font = LJFontSize12;
    self.briefLabel.text = @"火星小厨";
    [bgView addSubview:self.briefLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(bgView.lj_right - 70, 30, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(bgView.lj_right - 35, 30, 20, 20)];
    [btn1 setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn1];
    
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.lj_bottom + 2, SCREEN_WIDTH, 30)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView1];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 15)];
    stepLabel.lj_centerY = bgView1.lj_height / 2;
    stepLabel.lj_centerX = bgView1.lj_width / 2;
    stepLabel.textColor = LJFontColor61;
    stepLabel.font = LJFontSize14;
    stepLabel.textAlignment = NSTextAlignmentCenter;
    stepLabel.text = @"第1步";
    [bgView1 addSubview:stepLabel];
    self.stepLabel = stepLabel;
    
    self.scrollViewbottom = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bgView1.lj_bottom + 1, SCREEN_WIDTH, 140)];
    self.scrollViewbottom.lj_centerX = self.view.lj_centerX;
    self.scrollViewbottom.backgroundColor = [UIColor whiteColor];
    self.scrollViewbottom.contentSize = CGSizeMake(self.dataArray.count * SCREEN_WIDTH, 140);
    self.scrollViewbottom.pagingEnabled = YES;
    self.scrollViewbottom.delegate = self;
    self.scrollViewbottom.showsHorizontalScrollIndicator = NO;
    self.scrollViewbottom.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollViewbottom];
    
    for (int i = 0; i <self.dataArray.count; i++) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((35 * (i + 1) )+ (i *  (self.scrollViewbottom.lj_width - 70 )), 10, self.scrollViewbottom.lj_width - 70, 130)];
        if (i>=1) {
            textLabel.lj_x = 35+ (i)*70 + (i *  (self.scrollViewbottom.lj_width - 70 ));
        }
        textLabel.text = self.data1Array[i];
        textLabel.textColor = LJFontColor39;
        textLabel.font = LJFontSize14;
        textLabel.numberOfLines = 20;
        [self.scrollViewbottom addSubview:textLabel];
    }
    
    /*** 底部提示信息 ***/
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollViewbottom.lj_bottom+40, SCREEN_WIDTH / 2, 20)];
    self.tipLabel.lj_centerX = SCREEN_WIDTH / 2;
    self.tipLabel.text = @"向右滑动，开始学习！";
    self.tipLabel.textColor = LJFontColor39;
    self.tipLabel.font = LJFontSize15;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.tipLabel];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1,@1.2,@1.3,@0.9,@1.2,@0.95,@1];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.calculationMode = kCAAnimationCubic;
    [self.tipLabel.layer addAnimation:animation forKey:nil];
}

- (void)shareClick:(UIButton *)sender {
    LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleAlert3];
    [tip Alert3content:@"分享成功！" location:self.view.lj_centerY + 30];
}

-(void)collectClick:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@/cateid/%@/userid/%@",Collect,self.cateid,@"1"]; //USERDEFINE.currentUser.user_id
    [AFNetworkingAPI getWithPath:url Params:nil requrieDataBack:^(id  _Nonnull data) {
        LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleAlert3];
        [tip Alert3content:data location:self.view.lj_centerY + 30];
    }];
    
}

#pragma mark - <UIScrollViewDelegate>
// 在scrollView滚动动画结束时, 就会调用这个方法
// 前提: 人为拖拽scrollView产生的滚动动画
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollViewbottom) {
        CGPoint point = self.scrollViewbottom.contentOffset;
        NSInteger index = self.scrollViewbottom.contentOffset.x / SCREEN_WIDTH;
        point.x = index * 250;
        [self.scrollViewtop setContentOffset:point animated:YES];
        self.stepLabel.text = [NSString stringWithFormat:@"第%ld步",index + 1];
        if (index > 0 &&index != self.dataArray.count - 1) {
            self.tipLabel.text = @"左右滑动!";
        }else if (index == self.dataArray.count - 1){
            self.tipLabel.text = @"已到最后一步!";
        }else {
            self.tipLabel.text = @"向右滑动，继续学习！";
        }
    }else {
        CGPoint point = self.scrollViewtop.contentOffset;
        NSInteger index = self.scrollViewtop.contentOffset.x / 250;
        point.x = index * SCREEN_WIDTH;
        [self.scrollViewbottom setContentOffset:point animated:YES];
        self.stepLabel.text = [NSString stringWithFormat:@"第%ld步",index + 1];
        if (index > 0 &&index != self.dataArray.count - 1) {
            self.tipLabel.text = @"左右滑动!";
        }else if (index == self.dataArray.count - 1){
            self.tipLabel.text = @"已到最后一步!";
        }else {
            self.tipLabel.text = @"向右滑动，继续学习！";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

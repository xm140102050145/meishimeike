//
//  LJPublicViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 02/05/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJPublicViewController.h"
#import "DLImagePickerController.h"
@interface LJPublicViewController ()<UITextViewDelegate>
/*** 评价按钮 ***/
@property (nonatomic,strong) UIButton *evaluateBtn;
/*** 提示Label ***/
@property (nonatomic,strong) UILabel *placeholder;
/*** 输入框 ***/
@property (nonatomic,strong) UITextView *textView;
/*** 少于多少字 ***/
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *tipLable1;

/*** 选择图片控制器 ***/
@property (nonatomic,strong) DLImagePickerController *imagePickerVc;
@property (nonatomic,strong) NSMutableArray  *imageArray;
@end

@implementation LJPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发表感想";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self public];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)public {
    //评论区
    UIView *evaluateView = [[UIView alloc] initWithFrame:CGRectMake(5, 74, SCREEN_WIDTH - 10, 150)];
    evaluateView.backgroundColor = [UIColor whiteColor];
    evaluateView.layer.borderColor = LJCutLineColor.CGColor;
    evaluateView.layer.borderWidth = 1;
    [evaluateView setLayerWithCr:3];
    [self.view addSubview:evaluateView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(3, 3, evaluateView.lj_width - 6, evaluateView.lj_height - 6)];
    textView.delegate = self;
    textView.tintColor = LJFontColor61;
    textView.font = LJFontSize14;
    textView.textColor = LJFontColor61;
    [evaluateView addSubview:textView];
    self.textView = textView;
    
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(spaceEdgeW(10), spaceEdgeH(15), spaceEdgeW(150), spaceEdgeH(15))];
    self.placeholder.text = @"输入你的美食...";
    self.placeholder.font = LJFontSize14;
    self.placeholder.textColor = LJFontColor88;
    [evaluateView addSubview:self.placeholder];
    
    UILabel *tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 75, 0, 70, spaceEdgeH(13))];
    tipLabel1.lj_y = evaluateView.lj_bottom + 4;
    tipLabel1.text = @"少于100字";
    tipLabel1.textColor = LJFontColor61;
    tipLabel1.font = LJFontSize12;
    tipLabel1.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:tipLabel1];
    self.tipLabel = tipLabel1;
    
    /*** 图片选择器 ***/
    self.imagePickerVc = [[DLImagePickerController alloc] init];
    [self addChildViewController:self.imagePickerVc];
    self.imagePickerVc.view.frame = CGRectMake(0, tipLabel1.lj_bottom + spaceEdgeH(10), SCREEN_WIDTH, spaceEdgeH(230));
    [self.view addSubview:self.imagePickerVc.view];
    __weak typeof(self)WeakSelf = self;
    self.imagePickerVc.DlImagePickerAcquirePhotosBlock = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///------->>>>在这上传选择好的图片;
        WeakSelf.imageArray = [NSMutableArray arrayWithArray:photos];
    };
    
    //这个block是用来当点击删除按钮时，对应删除当前图片数组里的图片
    self.imagePickerVc.DlImagePickerDeletePhotosAtIndexBlock = ^(NSInteger index) {
        [WeakSelf.imageArray removeObjectAtIndex:index];
    };
    
    self.evaluateBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.evaluateBtn.backgroundColor = LJTheMeColor;
    self.evaluateBtn.lj_bottom = self.view.lj_bottom;
    [self.evaluateBtn setTitle:@"发 表" forState:UIControlStateNormal];
    [self.evaluateBtn.titleLabel setFont:LJFontSize16];
    [self.evaluateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal
     ];
    [self.evaluateBtn addTarget:self action:@selector(evaluateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.evaluateBtn];
}

#pragma mark --点击评价
- (void)evaluateBtnClick:(UIButton *)sender {
    NSDictionary *dic = @{@"conent":self.textView.text,@"userid":USERDEFINE.currentUser.user_id};
    [AFNetworkingClient uploadImagesWithPath:Suosuo Params:dic imagesArray:self.imageArray requrieDataBack:^(id  _Nonnull data) {
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.textView.text.length == 0) {
        self.tipLabel.text = @"少于100字";
        [self.placeholder setHidden:NO];
    }else{
        [self.placeholder setHidden:YES];
        self.tipLabel.text = [NSString stringWithFormat:@"%ld/100",(unsigned long)self.textView.text.length];
    }
}

#pragma mark --判断长度
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length - range.length + text.length > 100) {
        return NO;
    }
    return YES;
}

@end

//
//  LJVideoViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 07/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJVideoViewController.h"
#import "DLVideoPlayView.h"
#import "LJInputView.h"
#import "LJVideoDetailTableViewCell.h"

@interface LJVideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) DLVideoPlayView *playView;
@property (nonatomic,strong) LJInputView *InputView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation LJVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LJCommonBgColor;
    
    [self addPlayView];
    [self addtableView];
    [self load];
    [self addInputViewKeyBoard];
}

- (void)load {
    NSString *url = [NSString stringWithFormat:@"%@%@",Rvideocomment,self.NewsModel.cate_id];
    [AFNetworkingAPI getWithPath:url Params:nil requrieDataBack:^(id  _Nonnull data) {
        
        self.dataArray = [NSMutableArray array];
        self.dataArray = [LJNewsModel mj_objectArrayWithKeyValuesArray:data];
        [self.tableView reloadData];
    }];
}

- (void)addtableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.playView.lj_bottom, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.playView.lj_height - 40)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LJCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJVideoDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJVideoDetailTableViewCell"];
}

- (void)addPlayView {
    self.playView = [[DLVideoPlayView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT/ 3 )];
    [self.view addSubview:self.playView];
    [self.playView.collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    self.playView.viewbackframe = ^ (UIView *view) {
        view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT / 3);
    };
    self.playView.titleLabel.text = _NewsModel.cate_name;
    self.playView.URLStr = [NSURL URLWithString:_NewsModel.cate_stepvideo];
    [self.playView playVideoWithURL];
}


#pragma mark --添加输入框和注册键盘监听
- (void)addInputViewKeyBoard {
    self.InputView = [[LJInputView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [self.InputView.sendBtn addTarget:self action:@selector(ClickMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.InputView];
    //注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickHide:)];
    [self.tableView addGestureRecognizer:tap];
}

#pragma mark --发送消息
- (void)ClickMsg:(UIButton *)sender {
    if (![self.InputView.inputTextField.text isEqualToString:@""]) {
        LJNewsModel *newsModel = [[LJNewsModel alloc] init];
        newsModel.user_name = USERDEFINE.currentUser.user_name;
        newsModel.videocomment = self.InputView.inputTextField.text;
        newsModel.user_headimage = USERDEFINE.currentUser.user_headimage;
        newsModel.videocomment_time = [self getCurrentTimes];
        [self.dataArray addObject:newsModel];
        [self.tableView reloadData];
        [self upDateComment:self.InputView.inputTextField.text];
    }
    [self.InputView.inputTextField resignFirstResponder];
    self.InputView.inputTextField.text = @"";
}

#pragma mark --上传评论
-(void)upDateComment:(NSString *)comment {
    NSDictionary *dic = @{@"videocomment":comment,@"userid":USERDEFINE.currentUser.user_id,@"cateid":self.NewsModel.cate_id};
    [AFNetworkingAPI postWithPath:Commentvideo Params:dic requrieDataBack:^(id  _Nonnull data) {
        LJLog(@"上传评论:%@",data);
    }];
}

#pragma mark --点击手势
- (void)ClickHide:(UITapGestureRecognizer *)tapGesture {
    [self.view endEditing:YES];
}

#pragma mark --键盘出现
- (void)KeyboardShow:(NSNotification *)Notification {
    //键盘位置及宽高
    CGRect keyBoardRect = [Notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.InputView.lj_y = SCREEN_HEIGHT - keyBoardRect.size.height - 40;
    
}

#pragma mark --键盘消失
- (void)KeyboardHide:(NSNotification *)Notification {
   self.InputView.lj_y =  SCREEN_HEIGHT - 40;
}

- (void)collectClick:(UIButton *)sender {
    
}

- (void)setNewsModel:(LJNewsModel *)NewsModel {
    _NewsModel = NewsModel;
    self.navigationItem.title = NewsModel.cate_name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJVideoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJVideoDetailTableViewCell"];
    cell.NewsModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)dealloc {
    if (self.playView.isLoadResource) {
        [self.playView removeObserveAndNOtification];
        self.playView = nil;
    }
}

//获取当前的时间

- (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}

@end

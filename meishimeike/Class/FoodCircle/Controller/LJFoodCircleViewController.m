//
//  LJFoodCircleViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJFoodCircleViewController.h"
#import "LJSuosuoTableViewCell.h"
#import "LJInputView.h"
@interface LJFoodCircleViewController ()
@property (nonatomic,strong) LJInputView *InputView;
@end

@implementation LJFoodCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.lj_x = 5;
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
    //注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickHide:)];
    [self.tableView addGestureRecognizer:tap];
    [self publicComment];
}

#pragma mark --发表
- (void)publicComment {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithText:@"发表" hightext:nil color:LJTheMeColor highColor:nil target:self action:@selector(public)];
}

- (void)public {
    UIViewController *vc = [NSClassFromString(@"LJPublicViewController") new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --添加输入框和注册键盘监听
- (void)addInputViewKeyBoard:(NSInteger)cell {
    self.InputView = [[LJInputView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    self.InputView.sendBtn.tag = cell;
    [self.InputView.sendBtn addTarget:self action:@selector(ClickMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.InputView];
    [self.InputView.inputTextField becomeFirstResponder];
}

#pragma mark --发送消息
- (void)ClickMsg:(UIButton *)sender {
    LJSuoSuoModel *suoModel = self.dataArray[sender.tag];
    NSMutableArray *commentArray = suoModel.comment;
    LJCommentModel *commentModel = [[LJCommentModel alloc] init];
    commentModel.comment_id = @"";
    commentModel.comment_user_id = @"";
    commentModel.comment_content = self.InputView.inputTextField.text;
    commentModel.comment_followuser_id = @"";
    commentModel.user_name = USERDEFINE.currentUser.user_name;///当前用户名
    [commentArray addObject:commentModel];
    [self.tableView reloadData];
    [self KeyboardHide:nil];
    
    //上传评论数据 ------>>>>>>>>>>>
    
}

#pragma mark --点击手势
- (void)ClickHide:(UITapGestureRecognizer *)tapGesture {
    [self.view endEditing:YES];
    [self.InputView.inputTextField resignFirstResponder];
    [self.InputView removeFromSuperview];
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
    [self.InputView.inputTextField resignFirstResponder];
    [self.InputView removeFromSuperview];
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
    __weak typeof(self)weakself = self;
    cell.backCellIndex = ^(NSInteger cell) {
        //进行评论 ----》》》》》
        [weakself addInputViewKeyBoard:cell];
    };
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end

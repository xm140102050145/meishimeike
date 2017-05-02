//
//  LJNextPublishViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 08/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJNextPublishViewController.h"
#import "NSString+Extension.h"

#import "LJMeterialTableViewCell.h"
#import "LJMakeStepTableViewCell.h"
#import "LJTasteTableViewCell.h"

@interface LJNextPublishViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    CGFloat _height;
    NSInteger rowNum1; //第一个section的行数
    NSInteger rowNum2; //第二个section的行数
    NSInteger rowNum3; //第三个section的行数
    NSInteger sectionNum; //
    
    NSInteger _cell;
    NSInteger _tag;
}
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *placeholder;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) CGFloat h;

@property (nonatomic,strong) UIImageView *imageView;

/*** 用料数组 ***/
@property (nonatomic,strong) NSMutableArray *meterialArray;
@property (nonatomic,strong) NSMutableArray *meterialArray1;
/*** 步骤数组 ***/
@property (nonatomic,strong) NSMutableArray *stepArray;

@end

@implementation LJNextPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rowNum1 = rowNum2 = rowNum3 = 1;
    
    self.meterialArray = [NSMutableArray array];
    self.stepArray = [NSMutableArray array];
    self.meterialArray1 = [NSMutableArray array];
    
    self.tableView.lj_height = SCREEN_HEIGHT - 64;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"创建菜谱";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LJMeterialTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJMeterialTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJMakeStepTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJMakeStepTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJTasteTableViewCell" bundle:nil] forCellReuseIdentifier:@"LJTasteTableViewCell"];
    
    [self addObserver:self forKeyPath:@"h" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
    _height =  SCREEN_HEIGHT * 4 /5 - 60;
    
    [self creatHeader];
    [self creatFootView];
}


#pragma mark --创建头表单 ：包括：封面、菜谱名、简介
- (void)creatHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_height)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    //封面
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerView.lj_height * 2 /3 + 25)];
    imageView.backgroundColor = LJRandomColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, 20)];
    label.lj_centerX = imageView.lj_centerX;
    label.lj_centerY = imageView.lj_centerY;
    label.font = LJFontSize14;
    label.textColor = LJFontColor61;
    label.text = @"+菜谱封面";
    label.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
    
    [headerView addSubview:imageView];
    self.imageView = imageView;
    
    //菜谱名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.lj_bottom + 5, SCREEN_WIDTH / 2, 40)];
    nameLabel.lj_centerX = headerView.lj_centerX;
    nameLabel.font = [UIFont systemFontOfSize:25 weight:2];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = LJTheMeColor;
    nameLabel.text = self.cateName;
    [headerView addSubview:nameLabel];
    
    [headerView addSubview:[UIView setLineViewAtY:nameLabel.lj_bottom + 10]];
    
    //简介
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, nameLabel.lj_bottom + 20, SCREEN_WIDTH - 10, 35)];
    textView.lj_centerX = headerView.lj_centerX;
    textView.font = LJFontSize15;
    textView.textColor = LJFontColor39;
    [headerView addSubview:textView];
    textView.scrollEnabled = NO;
    textView.delegate = self;
    self.textView = textView;
    
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 200, 30)];
    self.placeholder.text = @"简单的介绍一下自己的菜谱";
    self.placeholder.font = LJFontSize15;
    self.placeholder.textColor = LJFontColor88;
    [textView addSubview:self.placeholder];
}

#pragma mark --创建尾表单
- (void)creatFootView {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [btn.titleLabel setFont: LJFontSize14];
    btn.backgroundColor = LJTheMeColor;
    [btn.titleLabel setTextColor:[UIColor whiteColor]];
    [btn setTitle:@"上传菜谱" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = btn;
}


#pragma mark --上传菜谱
- (void)upLoad {
    NSMutableString *dosageStr = [NSMutableString string];
    for (int i = 0; i < self.meterialArray1.count; i++) {
        NSDictionary *dic = self.meterialArray1[i];
        NSString *str = [NSString stringWithFormat:@"%@=%@",dic[@"cateName"],dic[@"dosage"]];
        if (i == self.meterialArray1.count - 1) {
            [dosageStr stringByAppendingString:[NSString stringWithFormat:@"%@",str]];
        }else {
           [dosageStr stringByAppendingString:[NSString stringWithFormat:@"%@/",str]];
        }
    }
    
//    [self.stepArray removeAllObjects];
    NSMutableString *conentStr = [NSMutableString string];
    for (int i = 0; i < rowNum1; i++) {
        LJMakeStepTableViewCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        NSString *str = [NSString stringWithFormat:@"%d.%@",i,cell.stepConent.text];
        if (i == rowNum1 - 1) {
            [conentStr stringByAppendingString:[NSString stringWithFormat:@"%@",str]];
        }else {
            [conentStr stringByAppendingString:[NSString stringWithFormat:@"%@/",str]];
        }
//        [self.stepArray addObject:cell.stepImageView.image];
    }
    
    [self upConent:dosageStr dosage:conentStr imageArray:self.stepArray];
}

#pragma mark --开始上传
- (void)upConent:(NSMutableString *)conentStr dosage:(NSMutableString *)dosageStr imageArray:(NSArray *)imageArray {
//    NSDictionary *dic = @{@"name":self.cateName,@"brief":self.textView.text,@"taste":@"甜",@"time":@"30min",@"crowd":@"皆宜",@"pay":@"煮",@"kind":self.cateKind,@"classify":@"2",@"material":dosageStr,@"tapy":@"1",@"stepconent":conentStr,@"userid":@"1"};
//    [AFNetworkingAPI uploadImagesWithPath:Publishcate Params:dic imagesArray:imageArray requrieDataBack:^(id  _Nonnull data) {
//    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LJMeterialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJMeterialTableViewCell"];
        if (self.meterialArray.count > 0&&indexPath.row - self.meterialArray.count != 0) {
            NSDictionary *dic = self.meterialArray[indexPath.row];
            cell.cateNameText.text = dic[@"cateName"];
            cell.dosageText.text = dic[@"dosage"];
            [self.meterialArray1 addObject:dic];
        }
        return cell;
    }else if (indexPath.section == 1) {
        LJMakeStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJMakeStepTableViewCell"];
        cell.cell = indexPath.row;
        __weak typeof(self)WeakSelf = self;
        cell.stepIView = ^(NSInteger step, NSInteger tag) {
            _cell = step;
            _tag = tag;
            [WeakSelf tap];
        };
        return cell;
    }else {
        LJTasteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LJTasteTableViewCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1) {
        return 400;
    }else if (indexPath.section == 2) {
        return 40;
    }
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return rowNum1;
    }else if (section == 1) {
        return rowNum2;
    }else if (section == 2) {
        return rowNum3;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    tipLabel.font = [UIFont systemFontOfSize:22 weight:2];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:tipLabel];
    
    //批量上传按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 50)];
    [button setTitleColor:LJTheMeColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [headerView addSubview:button];
    
    if (section == 0) {
        tipLabel.text = @"用料";
        return headerView;
    }else if (section == 1) {
        tipLabel.text = @"做法";
        [button setTitle:@"批量上传" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(batchUpdate) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
    }else if (section == 2) {
        tipLabel.font = LJFontSize14;
        tipLabel.text = @"美食口味";
        return headerView;
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    //增加按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 50)];
    [button setTitleColor:LJTheMeColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    //调整按钮
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 50)];
    [button1 setTitleColor:LJTheMeColor forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button1.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button1 addTarget:self action:@selector(adjustBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button1];
    
    if (section == 0) {
        [button setTitle:@"再增加一行" forState:UIControlStateNormal];
        [button1 setTitle:@"调整用料" forState:UIControlStateNormal];
        button1.tag = button.tag = 1000;
        return headerView;
    }else if (section == 1) {
        [button setTitle:@"再增加一步" forState:UIControlStateNormal];
        [button1 setTitle:@"调整步骤" forState:UIControlStateNormal];
        button1.tag = button.tag = 1001;
        return headerView;
    }else {
        headerView.lj_height = 0;
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

#pragma mark --增加按钮
- (void)addBtn:(UIButton *)sender {
    NSIndexSet *indexSet = [[NSIndexSet alloc] init];
    if (sender.tag == 1000) {
        [self.meterialArray removeAllObjects];
        for (int i = 0; i < rowNum1; i++) {
            LJMeterialTableViewCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            NSDictionary *dic = @{@"cateName":cell.cateNameText.text,@"dosage":cell.dosageText.text};
            [self.meterialArray addObject:dic];
        }
        rowNum1 ++;
        [self.meterialArray1 removeAllObjects];
        indexSet = [NSIndexSet indexSetWithIndex:0];
    }else if (sender.tag == 1001){
        rowNum2 ++;
        indexSet = [NSIndexSet indexSetWithIndex:1];
    }
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --调整按钮
- (void)adjustBtn:(UIButton *)sender {
    sectionNum = 0;
    if (sender.tag == 1000) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [self.tableView setEditing:YES animated:YES];
            [sender setTitle:@"完成调整" forState:UIControlStateNormal];
        }else {
            [self.tableView setEditing:NO animated:YES];
            [sender setTitle:@"调整用料" forState:UIControlStateNormal];
        }
        
    }else if (sender.tag == 1001){
        sectionNum = 1;
        sender.selected = !sender.selected;
        if (sender.selected) {
            [self.tableView setEditing:YES animated:YES];
            [sender setTitle:@"完成调整" forState:UIControlStateNormal];
        }else {
            [self.tableView setEditing:NO animated:YES];
            [sender setTitle:@"调整步骤" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark --批量上传事件
- (void)batchUpdate {
    LJLogFunc
}

#pragma mark - 移动

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sectionNum) {
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //让表视图对应的行进行移动
    [tableView exchangeSubviewAtIndex:sourceIndexPath.row withSubviewAtIndex:destinationIndexPath.row];
}


#pragma mark --删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sectionNum) {
        return YES;
    }
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       if (indexPath.section == sectionNum) {
           if (sectionNum == 0) {
               if (self.meterialArray.count > 0&&indexPath.row - self.meterialArray.count != 0) {
                   [self.meterialArray removeObjectAtIndex:indexPath.row];
               }
               rowNum1--;
           }else if (sectionNum == 1) {
               rowNum2--;
           }
          [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
       }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     if (scrollView == self.tableView) {
         UITableView *tableview = (UITableView *)scrollView;
         CGFloat sectionHeaderHeight = 60;
         CGFloat sectionFooterHeight = 60;
         CGFloat offsetY = tableview.contentOffset.y;
         if (offsetY >= 0 && offsetY <= sectionHeaderHeight) {
             tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
         }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight) {
               tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
         }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)  {
                tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
         }
    }
}

#pragma mark --封面手势
- (void)tapp {
    _tag = 10;
    [self tap];
}


- (void)tap {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *button1=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }];
    UIAlertAction *button2=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /***创建图片选择器***/
        UIImagePickerController* picker=[[UIImagePickerController alloc]init];
        /***设置选择器选择资源的类型***/
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        picker.allowsEditing=YES;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *button3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark-imagepicker代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image=[info objectForKey:UIImagePickerControllerEditedImage];
    if (image==nil) {
        image=[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if(_tag == 12) {
        LJMakeStepTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_cell inSection:1]];
        cell.stepImageView.image = image;
    }else if(_tag == 10) {
        self.imageView.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)textViewDidChange:(UITextView *)textView {
    if (self.textView.text.length == 0) {
        [self.placeholder setHidden:NO];
        self.headerView.lj_height = _height;
        self.tableView.tableHeaderView = self.headerView;
        self.textView.lj_height = 35;
        self.h = [self.placeholder.text heightWithWidth:SCREEN_WIDTH - 20 font:15];
    }else{
        self.h = [self.textView.text heightWithWidth:SCREEN_WIDTH - 20 font:15];
        [self.placeholder setHidden:YES];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([change[@"new"] floatValue] > 18) {
        if ([change[@"new"] floatValue] > [change[@"old"] floatValue]) {
            self.textView.lj_height = self.h + 18;
            self.headerView.lj_height = self.h + _height - 17;
            self.tableView.tableHeaderView = self.headerView;
            CGPoint point = self.tableView.contentOffset;
            point.y += 18;
            [self.tableView setContentOffset:point animated:YES];
        }else if([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            self.textView.lj_height = self.h + 18;
            self.headerView.lj_height = self.h + _height - 17;
            self.tableView.tableHeaderView = self.headerView;
            CGPoint point = self.tableView.contentOffset;
            point.y -= 18;
            [self.tableView setContentOffset:point animated:YES];
        }
    }else if([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
        self.textView.lj_height = self.h + 18;
        self.headerView.lj_height = self.h + _height - 17;
        self.tableView.tableHeaderView = self.headerView;
        CGPoint point = self.tableView.contentOffset;
        point.y -= 18;
        [self.tableView setContentOffset:point animated:YES];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView setContentOffset:CGPointMake(0, SCREEN_HEIGHT / 2 - 80) animated:YES];
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"h"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

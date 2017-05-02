//
//  LJUserInfoViewController.m
//  xianchufang
//
//  Created by zhenglong duan on 15/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJUserInfoViewController.h"
#import "LJUserHeaderTableViewCell.h"
#import "LJTooltip.h"
#import "LJModifyPhoneNumViewController.h"
@interface LJUserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/*** 头像 ***/
@property (nonatomic,strong) UIImageView *headerImageView;
/*** 昵称 ***/
@property (nonatomic,strong) NSString *userName;
/*** 手机号 ***/
@property (nonatomic,strong) NSString *userIphone;
/*** 性别 ***/
@property (nonatomic,strong) NSString *userSex;
/*** 年龄 ***/
@property (nonatomic,strong) NSString *userAge;

@end
static NSString *const LJUserHeaderTableViewCellId = @"LJUserHeaderTableViewCell";
@implementation LJUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, spaceEdgeH(267)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO; //去掉弹性效果
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LJUserHeaderTableViewCell class] forCellReuseIdentifier:LJUserHeaderTableViewCellId]; //注册自定义cell
    
    [self loadData];
}

#pragma mark --数据获取
- (void)loadData {
    self.dataArray = [NSMutableArray arrayWithObjects:@"小小",@"18621761223",@"男",@"2003/3/25" ,nil];
    self.userName = self.dataArray[0];
    self.userIphone = self.dataArray[1];
    self.userSex = self.dataArray[2];
    self.userAge = self.dataArray[3];
    [self.tableView reloadData];
}

#pragma mark --代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        LJUserHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LJUserHeaderTableViewCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //不让点击
        NSString *url = [NSString stringWithFormat:@"%@%@",headerUrl,USERDEFINE.currentUser.user_headimage];
        [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        cell.imageViewblock = ^(){
            LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleHeader];
            [tip showTooltip];
        };
        return cell;
    }
    static NSString* cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //指示器
    [cell.textLabel setFont:LJFontSize16];
    [cell.detailTextLabel setFont:LJFontSize16];
    [cell.textLabel setTextColor:LJFontColor61];
    [cell.detailTextLabel setTextColor:LJFontColor88];
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text =@"昵称";
            cell.detailTextLabel.text = self.userName;
            break;
        case 2:
            cell.textLabel.text =@"手机号";
            cell.detailTextLabel.text = self.userIphone;
            break;
        case 3:
            cell.textLabel.text =@"性别";
            cell.detailTextLabel.text = self.userSex;
            break;
        case 4:
            cell.textLabel.text =@"生日";
            cell.detailTextLabel.text = self.userAge;
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        return spaceEdgeH(90);
    }
    return spaceEdgeH(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleHeader];
        [tip showTooltip];
        tip.okClickBlock =^(NSString *str) {
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            if([str isEqualToString:@"相机"]){   //调用相机
                 PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else if ([str isEqualToString:@"图库"]){  //调用图库
                 PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self presentViewController:PickerImage animated:YES completion:nil];
        };
    }else if (indexPath.row ==1){
        LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleName];
        [tip showTooltip];
        tip.okClickBlock = ^(NSString *name){
            self.userName = name;
            [self.tableView  reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //在这将更换的信息上传到数据库中  ---->
        };
    }
    else if (indexPath.row ==2){
        __weak LJUserInfoViewController *weakSelf =self;
        LJModifyPhoneNumViewController *Vc =[[LJModifyPhoneNumViewController alloc] init];
        [Vc returnPhoneNum:^(NSString *phoneNum) {
            weakSelf.userIphone = phoneNum;
            [weakSelf.tableView  reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    else if (indexPath.row ==3){
        LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleSex];
        [tip showTooltip];
        tip.okClickBlock = ^(NSString *Sex){
            self.userSex = Sex;
            [self.tableView  reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //在这将更换的信息上传到数据库中  ---->
        };
    }
    else if (indexPath.row ==4){
        LJTooltip *tip = [[LJTooltip alloc] initWithToolTipStyle:ToolTipStyleAge];
        [tip showTooltip];
        tip.okClickBlock = ^(NSString *strData){
            self.userAge = strData;
            [self.tableView  reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //在这将更换的信息上传到数据库中  ---->
        };
    }
}

#pragma mark-imagepicker代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    LJUserHeaderTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.ImageView.image = image;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    [AFNetworkingClient uploadImagesWithPath:Updateheaderimg Params:@{@"userid":USERDEFINE.currentUser.user_id} imagesArray:@[image] requrieDataBack:^(id  _Nonnull data) {
        
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

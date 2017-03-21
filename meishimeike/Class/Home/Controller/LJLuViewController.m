//
//  LJLuViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJLuViewController.h"

@interface LJLuViewController ()

@end

@implementation LJLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"lu1@2x",@"lu2@2x",@"lu3@2x",@"lu4@2x"];
}

//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LJcateStartViewController *cate = [[LJcateStartViewController alloc] init];
    if (indexPath.row == 0) {
        cate.cateid = @"";
    }else if (indexPath.row == 1) {
        cate.cateid = @"";
    }else if (indexPath.row == 2) {
        cate.cateid = @"";
    }else if (indexPath.row == 3) {
        cate.cateid = @"";
    }
    [self.navigationController pushViewController:cate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

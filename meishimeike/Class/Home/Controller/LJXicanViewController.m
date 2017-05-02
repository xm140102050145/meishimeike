//
//  LJXicanViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 02/05/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJXicanViewController.h"

@interface LJXicanViewController ()

@end

@implementation LJXicanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"西餐";
    self.arr = @[];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

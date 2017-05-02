//
//  LJYuViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJYuViewController.h"

@interface LJYuViewController ()

@end

@implementation LJYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

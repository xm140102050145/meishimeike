//
//  LJcateStartViewController.h
//  meishimeike
//
//  Created by zhenglong duan on 21/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJcateStartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cateImageSmallView;
@property (weak, nonatomic) IBOutlet UILabel *OwnNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *sweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *potBtn;
@property (weak, nonatomic) IBOutlet UIButton *peopleBtn;


@property (weak, nonatomic) IBOutlet UILabel *catename;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

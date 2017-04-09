//
//  LJVideoDetailTableViewCell.h
//  meishimeike
//
//  Created by zhenglong d/Users/zhenglongduan/Desktop/Meishimeke/meishimeike/meishimeike/Class/publish/LJMeterialTableViewCell.huan on 07/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJNewsModel.h"
@interface LJVideoDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (nonatomic,strong) LJNewsModel *NewsModel;
@end

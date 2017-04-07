//
//  LJVideoTableViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 07/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJNewsModel;

@interface LJVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titilLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;

@property (nonatomic,strong) LJNewsModel *NewsModel;
@end

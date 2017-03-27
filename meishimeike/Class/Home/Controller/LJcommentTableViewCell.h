//
//  LJcommentTableViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommentModel.h"
@interface LJcommentTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *commentUserNameLabel;
@property (nonatomic,strong) UILabel *commentContentLabel;
@property (nonatomic,strong) LJCommentModel *commentModel;
@end

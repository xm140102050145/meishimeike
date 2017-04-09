//
//  LJMeterialTableViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 09/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJMeterialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *cateNameText;

/*** 用量 ***/
@property (weak, nonatomic) IBOutlet UITextField *dosageText;

@end

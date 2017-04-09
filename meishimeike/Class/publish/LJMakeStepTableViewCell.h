//
//  LJMakeStepTableViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 09/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJMakeStepTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stepImageView;
@property (weak, nonatomic) IBOutlet UITextView *stepConent;

@end

//
//  LJMakeStepTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 09/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJMakeStepTableViewCell.h"

@implementation LJMakeStepTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    self.stepImageView.userInteractionEnabled = YES;
    [self.stepImageView addGestureRecognizer:tap];

    
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 200, 30)];
    self.placeholder.text = @"简单介绍一下步骤...";
    self.placeholder.font = LJFontSize15;
    self.placeholder.textColor = LJFontColor88;
    [self.stepConent addSubview:self.placeholder];
}


- (void)textViewDidChange:(UITextView *)textView {
    if (self.stepConent.text.length == 0) {
        [self.placeholder setHidden:NO];
    }else{
        [self.placeholder setHidden:YES];
    }
}

#pragma mark --封面手势
- (void)tap {
    if (self.stepIView) {
        self.stepIView(self.cell,12);
    }
}

- (void)setCell:(NSInteger)cell {
   self.stepLabel.text = [NSString stringWithFormat:@"步骤%ld",cell + 1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

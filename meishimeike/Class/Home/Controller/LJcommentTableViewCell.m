//
//  LJcommentTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJcommentTableViewCell.h"

@implementation LJcommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.commentUserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 14)];
        self.commentUserNameLabel.textColor = [UIColor blueColor];
        self.commentUserNameLabel.font = LJFontSize14;
        self.commentUserNameLabel.textAlignment = NSTextAlignmentRight;
        self.commentUserNameLabel.text = @"段大大:";
        [self.contentView addSubview:self.commentUserNameLabel];
        
        self.commentContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.commentUserNameLabel.lj_right + 3, 0, SCREEN_WIDTH - self.commentUserNameLabel.lj_width - 10, 0)];
        self.commentContentLabel.textColor = LJFontColor39;
        self.commentContentLabel.font = LJFontSize14;
        self.commentContentLabel.text = @"段大大:段大大:段大大:段大大:段大大:段大大:段大大:";
        self.commentContentLabel.numberOfLines = 0;
        [self.commentContentLabel sizeToFit];
        [self.contentView addSubview:self.commentContentLabel];   
    }
    return self;
}

- (void)setCommentModel:(LJCommentModel *)commentModel {
    _commentModel = commentModel;
    self.commentUserNameLabel.text = [NSString stringWithFormat:@"%@:",commentModel.user_name];
    self.commentContentLabel.text = commentModel.comment_content;
    [self.commentContentLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

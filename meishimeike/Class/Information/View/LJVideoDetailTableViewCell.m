//
//  LJVideoDetailTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 07/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJVideoDetailTableViewCell.h"

@implementation LJVideoDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.userImageView setLayerWithCr:20];
}

-(void)setNewsModel:(LJNewsModel *)NewsModel {
    _NewsModel = NewsModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",headerUrl,NewsModel.user_headimage];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.userNameLabel.text = NewsModel.user_name;
    self.commentLabel.text = NewsModel.videocomment;
    self.timeLabel.text = NewsModel.videocomment_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

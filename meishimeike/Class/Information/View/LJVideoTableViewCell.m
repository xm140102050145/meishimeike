//
//  LJVideoTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 07/04/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJVideoTableViewCell.h"
#import "LJNewsModel.h"
@implementation LJVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsModel:(LJNewsModel *)NewsModel {
    _NewsModel = NewsModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",bgimageUrl,NewsModel.cate_bgimage];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titilLabel.text = NewsModel.cate_name;
    self.briefLabel.text = NewsModel.cate_brief;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

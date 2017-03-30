//
//  LJMyCollectDetailTableViewCell.m
//  xianchufang
//
//  Created by zhenglong duan on 22/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJMyCollectDetailTableViewCell.h"

@implementation LJMyCollectDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cateimageview = [[UIImageView alloc] init];
        self.cateimageview.backgroundColor = LJRandomColor;
        [self.contentView addSubview:self.cateimageview];
        
        self.catenamelabel = [[UILabel alloc] init];
        self.catenamelabel.textColor = LJFontColor39;
        self.catenamelabel.font = LJFontSize15;
        self.catenamelabel.text = @"糖醋排骨";
        [self.contentView addSubview:self.catenamelabel];
        
        self.briefLabel = [[UILabel alloc] init];
        self.briefLabel.textColor = LJFontColor61;
        self.briefLabel.font = LJFontSize14;
        self.briefLabel.numberOfLines = 0;
        self.briefLabel.text = @"dsjf k； 嗶昌； 哪里有卖明洁；呼呼大睡汪睡太晚一jhlj上";
        [self.contentView addSubview:self.briefLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cateimageview.frame = CGRectMake(10, 5, 70, 70);
    
    self.catenamelabel.frame = CGRectMake(self.cateimageview.lj_right + 8, 5, 150, 15);
    self.briefLabel.frame = CGRectMake(self.cateimageview.lj_right + 8, self.catenamelabel.lj_bottom + 5, 200, 0);
    [self.briefLabel sizeToFit];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    NSString *url = [NSString stringWithFormat:@"%@%@",foodimageUrl,dic[@"cate_bgimage"]];
    [self.cateimageview sd_setImageWithURL:[NSURL URLWithString:url]];
    self.catenamelabel.text = dic[@"cate_name"];
    self.briefLabel.text = dic[@"cate_brief"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

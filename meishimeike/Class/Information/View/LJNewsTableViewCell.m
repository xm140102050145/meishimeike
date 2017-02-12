//
//  LJNewsTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 12/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJNewsTableViewCell.h"
@interface LJNewsTableViewCell ()
/*** 图片 ***/
@property (nonatomic,strong) UIImageView *newsImageView;
/*** 标题 ***/
@property (nonatomic,strong) UILabel *titleLabel;
/*** 摘要 ***/
@property (nonatomic,strong) UILabel *priefLabel;
/*** 时间 ***/
@property (nonatomic,strong) UILabel *timeLabel;
@end
@implementation LJNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /*** 图片 ***/
        self.newsImageView = [[UIImageView alloc] init];
        self.newsImageView.backgroundColor = LJRandomColor;
        [self.contentView addSubview:self.newsImageView];
        [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.width.height.mas_equalTo(80);
        }];
        /*** 标题 ***/
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16 weight:1]];
        self.titleLabel.text = @"yyy文字";
        self.titleLabel.backgroundColor = LJRandomColor;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.newsImageView.mas_right).offset(5);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(self.contentView.lj_width - 100);
            make.height.mas_equalTo(18);
        }];
        /*** 摘要 ***/
        self.priefLabel = [[UILabel alloc] init];
        [self.priefLabel setFont:[UIFont systemFontOfSize:14 weight:0.2]];
        self.priefLabel.text = @"dhfadshflhjdsfhjdsfhdsfjhasjdfhlj一瑁践 残疾证中ugjjkhgjkghjgjgjgjhgjgjgjhgjh";
        self.priefLabel.numberOfLines = 0;
        [self.priefLabel sizeToFit];
        self.priefLabel.backgroundColor = LJRandomColor;
        [self.contentView addSubview:self.priefLabel];
        [self.priefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.newsImageView.mas_right).offset(5);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(self.contentView.lj_width - 100);
            make.height.mas_equalTo(50);
        }];
        /*** 时间 ***/
        self.timeLabel = [[UILabel alloc] init];
        [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
        self.timeLabel.text = @"2017-02-12";
        [self.timeLabel sizeToFit];
        self.timeLabel.backgroundColor = LJRandomColor;
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priefLabel.mas_bottom).offset(2);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.height.mas_equalTo(10);
        }];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

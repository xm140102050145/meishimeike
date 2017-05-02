//
//  LJUserHeaderTableViewCell.m
//  xianchufang
//
//  Created by zhenglong duan on 15/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJUserHeaderTableViewCell.h"

@implementation LJUserHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaceEdgeW(17), spaceEdgeH(34), 0, 0)];
        self.TextLabel.text = @"头像";
        [self.TextLabel setFont:LJFontSize16];
        [self.TextLabel setTextColor:LJFontColor61];
        [self.TextLabel sizeToFit];
        [self.contentView addSubview:self.TextLabel];
        
        self.ImageView = [[UIImageView alloc] init];
        [self.ImageView setLayerWithCr:25];
        self.ImageView.backgroundColor = [UIColor redColor];
        self.ImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClickBlock:)];
        [self.ImageView addGestureRecognizer:tap];
        [self.contentView addSubview:self.ImageView];
    }
    return self;
}
#pragma mark --点击imageView
- (void)imageViewClickBlock:(UITapGestureRecognizer *)tap {
    if (self.imageViewblock) {
        self.imageViewblock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(50);
        make.right.equalTo(self).offset(-10);
    }];
}

@end

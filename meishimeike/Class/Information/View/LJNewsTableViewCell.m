//
//  LJNewsTableViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 12/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJNewsTableViewCell.h"
#import "DLVideoPlayView.h"
@interface LJNewsTableViewCell ()

@property (nonatomic,strong) DLVideoPlayView *playView;

@end
@implementation LJNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                self.playView = [[DLVideoPlayView alloc] init];
                [self addSubview:self.playView];
                [self.playView.collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
        __weak typeof(self)weakSeaf = self;
        self.playView.frame = self.contentView.bounds;
        self.playView.viewbackframe = ^ (UIView *view) {
            view.frame = weakSeaf.contentView.bounds;
            [weakSeaf.contentView addSubview:view];
        };
}

- (void)collectClick:(UIButton *)sender {
    
}

- (void)setNewsModel:(LJNewsModel *)newsModel {
    _newsModel = newsModel;
        self.playView.titleLabel.text = _newsModel.cate_name;
        self.playView.URLStr = [NSURL URLWithString:_newsModel.cate_stepvideo];
    [self.playView playVideoWithURL];
}

- (void)dealloc {
    self.playView = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  LJtowCollectionReusableView.m
//  meishimeike
//
//  Created by zhenglong duan on 15/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJtowCollectionReusableView.h"

@implementation LJtowCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 6)];
        view.backgroundColor = LJCommonBgColor;
        [self addSubview:view];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, SCREEN_WIDTH, 35)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = LJFontSize16;
        self.titleLabel.textColor = LJTheMeColor;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    _titleLabel = titleLabel;
    _titleLabel.text = titleLabel.text;
}

@end

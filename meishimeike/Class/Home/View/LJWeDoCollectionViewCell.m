//
//  LJWeDoCollectionViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 15/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJWeDoCollectionViewCell.h"

@implementation LJWeDoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = LJCutLineColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

@end

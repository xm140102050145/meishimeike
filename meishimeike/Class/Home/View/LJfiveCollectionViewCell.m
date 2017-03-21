//
//  LJfiveCollectionViewCell.m
//  meishimeike
//
//  Created by zhenglong duan on 15/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJfiveCollectionViewCell.h"

@implementation LJfiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)c1:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender.tag);
    }
}
- (IBAction)c2:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender.tag);
    }
}
- (IBAction)c3:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender.tag);
    }
}

@end

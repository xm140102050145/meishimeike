//
//  DLCycleBannerViewCell.m
//  DLCycleBannerVIew
//
//  Created by zhenglong duan on 13/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "DLCycleBannerViewCell.h"

@implementation DLCycleBannerViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        _imageView.frame = self.bounds;
    }
    return self;
}
@end

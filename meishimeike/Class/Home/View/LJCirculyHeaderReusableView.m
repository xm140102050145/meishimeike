//
//  LJCirculyHeaderReusableView.m
//  xianchufang
//
//  Created by zhenglong duan on 08/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJCirculyHeaderReusableView.h"


@implementation LJCirculyHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *imagesArray = @[@"z3@2x",@"z4@2x",@"z2@2x",@"z1@2x"];
        // 创建不带标题的图片轮播器
        self.cycleBannerView = [[DLCycleBannerView alloc] initWithFrame:self.bounds];
        self.cycleBannerView.localiztionImagesArray = imagesArray;
        self.cycleBannerView.placeholderImage = [UIImage imageNamed:@"homepagebannerplaceholder"];
        [self addSubview:self.cycleBannerView];
    }
    return self;
}
@end

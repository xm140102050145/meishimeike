//
//  LJCommentModel.m
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJCommentModel.h"
#import "NSString+Extension.h"
@implementation LJCommentModel
- (CGFloat)cellHeight {
    _cellHeight = 10;
    CGFloat h =[self.comment_content heightWithWidth:SCREEN_WIDTH - 70 font:14];
    _cellHeight += h;
    return _cellHeight;
}

@end

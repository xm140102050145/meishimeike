//
//  LJSuoSuoModel.m
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJSuoSuoModel.h"
#import "NSString+Extension.h"


@implementation LJSuoSuoModel
- (CGFloat)cellHight {
    _cellHight = 50;
    _cellHight += [self.suosuo_conent heightWithWidth:250 font:14];
    if (self.suosuo_image.length >0) {
        _cellHight+= 90;
    }
    if (self.comment.count >0) {
       CGFloat h = 20 * self.comment.count;
        _cellHight += h;
    }
    _cellHight += 40;
    return _cellHight;
}
@end

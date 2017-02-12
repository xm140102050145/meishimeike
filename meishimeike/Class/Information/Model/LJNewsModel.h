//
//  LJNewsModel.h
//  meishimeike
//
//  Created by zhenglong duan on 12/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNewsModel : NSObject
//"news_id": "1",
//"news_title": " 阿尔伯特·爱因斯坦",
//"news_image": "589a8a0f391da.jpg",
//"news_prief": "如果你无法简洁的表达你的想法，那只说明你还不够了解它。 -- 阿尔伯特·爱因斯坦",
//"news_time": "2017-2-11"
@property (nonatomic,strong) NSString *news_id;
@property (nonatomic,strong) NSString *news_title;
@property (nonatomic,strong) NSString *news_image;
@property (nonatomic,strong) NSString *news_prief;
@property (nonatomic,strong) NSString *news_time;
@end

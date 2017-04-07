//
//  LJNewsModel.h
//  meishimeike
//
//  Created by zhenglong duan on 12/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNewsModel : NSObject
//"cate_bgimage": "",
//"cate_brief": "逍遥镇胡辣汤是中华风味名吃之一"
//"videocomment": "这美特斯邦威",
//"user_name": "大大",
//"user_headimage": "589ac1418ef1a.jpg"
@property (nonatomic,strong) NSString *cate_name;
@property (nonatomic,strong) NSString *cate_stepvideo;
@property (nonatomic,strong) NSString *cate_bgimage;
@property (nonatomic,strong) NSString *cate_brief;
@property (nonatomic,strong) NSString *cate_id;
@property (nonatomic,strong) NSString *videocomment;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *user_headimage;
@property (nonatomic,strong) NSString *videocomment_time;
@end

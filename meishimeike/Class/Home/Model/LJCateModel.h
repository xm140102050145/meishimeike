//
//  LJCateModel.h
//  meishimeike
//
//  Created by zhenglong duan on 21/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>
//"cate_name": "糖醋里脊",
//"cate_bgimage": "tangchuliji.png",
//"cate_taste": "甜",
//"cate_time": "30min",
//"cate_crowd": "皆宜",
//"cate_pay": "炒",
//"cate_material": "鸡肉",
//"cate_collectnum": "0",
//"cate_tapy": "1",
//"user_headimage": "589ac1418ef1a.jpg",
//"user_name": "大大"
//"cate_stepimage": "589d55ccebcc0.jpg",
//"cate_stepconent": "1.........2.......3.......",
//"cate_makenum": "14"
@interface LJCateModel : NSObject
@property (nonatomic,strong) NSString *cate_id;
@property (nonatomic,strong) NSString *cate_name;
@property (nonatomic,strong) NSString *cate_brief;
@property (nonatomic,strong) NSString *cate_kind;
@property (nonatomic,strong) NSString *cate_classify;
@property (nonatomic,strong) NSString *cate_bgimage;
@property (nonatomic,strong) NSString *cate_time;
@property (nonatomic,strong) NSString *cate_taste;
@property (nonatomic,strong) NSString *cate_crowd;
@property (nonatomic,strong) NSString *cate_pay;
@property (nonatomic,strong) NSString *cate_material;
@property (nonatomic,strong) NSString *cate_collectnum;
@property (nonatomic,strong) NSString *cate_tapy;
@property (nonatomic,strong) NSString *user_headimage;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *cate_stepvideo;
@property (nonatomic,strong) NSString *cate_stepimage;
@property (nonatomic,strong) NSString *cate_stepconent;
@property (nonatomic,strong) NSString *cate_makenum;
@end

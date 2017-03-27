//
//  LJSuoSuoModel.h
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJCommentModel.h"
@interface LJSuoSuoModel : NSObject
//"suosuo_id": "4",
//"suosuo_conent": "真好吃",
//"suosuo_image": "589d7743943ef.jpg589d774393d4d.jpg589d77439397a.jpg",
//"suosuo_user_id": "1",
//"user_headimage": "589ac1418ef1a.jpg",
//"user_name": "大大",
@property (nonatomic,strong) NSString *suosuo_id;
@property (nonatomic,strong) NSString *suosuo_conent;
@property (nonatomic,strong) NSString *suosuo_image;
@property (nonatomic,strong) NSString *suosuo_user_id;
@property (nonatomic,strong) NSString *user_headimage;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSArray *comment;

@property (nonatomic,assign) CGFloat cellHight;
@end

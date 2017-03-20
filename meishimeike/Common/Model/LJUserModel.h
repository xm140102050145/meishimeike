//
//  LJUserModel.h
//  meishimeike
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJUserModel : NSObject
/*用户ID*/
@property (nonatomic,strong) NSString *user_id;
/*用户昵称*/
@property (strong, nonatomic) NSString *user_name;
/*用户电话*/
@property (strong, nonatomic) NSString *user_phone;
/*用户密码*/
@property (strong, nonatomic) NSString *user_password;
/*用户头像*/
@property (strong, nonatomic) NSString *user_headimage;
/*用户美食圈背景*/
@property (strong, nonatomic) NSString *user_bgimage;
@end

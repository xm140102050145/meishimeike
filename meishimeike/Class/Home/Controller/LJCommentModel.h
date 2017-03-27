//
//  LJCommentModel.h
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJCommentModel : NSObject
//"comment_id": "1",
//"comment_user_id": "1",
//"comment_content": "这个菜可以",
//"comment_followuser_id": "2",
//"user_name": "食客"
@property (nonatomic,strong) NSString *comment_id;
@property (nonatomic,strong) NSString *comment_user_id;
@property (nonatomic,strong) NSString *comment_content;
@property (nonatomic,strong) NSString *comment_followuser_id;
@property (nonatomic,strong) NSString *user_name; //评论者的名字

@property (nonatomic,assign) CGFloat cellHeight;
@end

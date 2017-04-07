//
//  LJTabBar.h
//  meishimeike
//
//  Created by zhenglong duan on 11/02/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^presentView)(UIViewController *publishView);
@interface LJTabBar : UITabBar
/*** 中间发布按钮  ***/
@property(nonatomic,strong)UIButton *publishButton;
/** 可变字典，保存音效ID */
@property (nonatomic, strong) NSMutableDictionary * soundIDs;

@property (nonatomic,copy) presentView publishView;
@end

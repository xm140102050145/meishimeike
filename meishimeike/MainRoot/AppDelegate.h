//
//  AppDelegate.h
//  meishimeike
//
//  Created by zhenglong duan on 20/12/2016.
//  Copyright © 2016 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJUserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*声明一个用户模型属性 作为当前登陆用户*/
@property (strong, nonatomic) LJUserModel* currentUser;
@end


//
//  LJSuosuoTableViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 27/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSuoSuoModel.h"
#import "LJCommentModel.h"

typedef void(^backCellIndex)(NSInteger index);
@interface LJSuosuoTableViewCell : UITableViewCell
@property (nonatomic,strong) LJSuoSuoModel *suosuoModel;
@property (nonatomic,copy) backCellIndex backCellIndex ;
@property (nonatomic,assign) NSInteger cell;
@end

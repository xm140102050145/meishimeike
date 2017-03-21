//
//  LJfiveCollectionViewCell.h
//  meishimeike
//
//  Created by zhenglong duan on 15/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^back)(NSInteger tag);
@interface LJfiveCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (nonatomic,copy) back backBlock;
@end

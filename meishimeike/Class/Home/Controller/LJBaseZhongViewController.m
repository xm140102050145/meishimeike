//
//  LJBaseZhongViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJBaseZhongViewController.h"
#import "LJZhongcanCollectionViewCell.h"

@interface LJBaseZhongViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/*** 主要 :CollectionView ***/
@property (nonatomic,strong) UICollectionView *LJCollectionView;
@end

@implementation LJBaseZhongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBaseInfo];       //1.配置configureBaseInfo基本属性
    [self configureCollectionView]; //2.配置collectionView属性
}

#pragma mark --configureBaseInfo
- (void)configureBaseInfo {
    //1.设置自动布局为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark --configureCollectionView
- (void)configureCollectionView {
    //1.创建流水布局(布局对象)
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //2.创建UICollectionView对象, 将layout添加到collectionViewLayout:里面
    self.LJCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    //3.设置UICollectionView基本属性
    self.LJCollectionView.backgroundColor = LJCommonBgColor;
    self.LJCollectionView.delegate = self;
    self.LJCollectionView.dataSource = self;
    self.LJCollectionView.showsVerticalScrollIndicator = NO;
    //4.注册cell 从上到下顺序
    [self.LJCollectionView registerNib:[UINib nibWithNibName:@"LJZhongcanCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LJZhongcanCollectionViewCell"];
  
    [self.view addSubview:self.LJCollectionView];
}

#pragma mark --collectionView DataSource
//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LJZhongcanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJZhongcanCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark --collectionView Delegate
// 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd",indexPath.item);
}

#pragma mark --UICollectionViewDelegateFlowLayout
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    return CGSizeMake(150, 190);
}
//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//动态设置某组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

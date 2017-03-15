//
//  LJHomeViewController.m
//  meishimeike
//
//  Created by zhenglong duan on 15/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "LJHomeViewController.h"
#import "LJMenuItemCollectionViewCell.h"
#import "LJWeDoCollectionViewCell.h"
#import "LJfiveCollectionViewCell.h"
#import "LJtowCollectionReusableView.h"

@interface LJHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/*** 主要 :CollectionView ***/
@property (nonatomic,strong) UICollectionView *LJCollectionView;
/*** 存放菜单的数据 ***/
@property (nonatomic,strong) NSArray *meunArray;
@end

@implementation LJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBaseInfo];       //1.配置configureBaseInfo基本属性
    [self configureCollectionView]; //2.配置collectionView属性
    [self setNavIcon];
}
    
#pragma mark --configureBaseInfo
- (void)configureBaseInfo {
    //1.设置自动布局为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"美食美客";
    self.meunArray = @[@{@"icon":@"home_chinesefood_selected_icon",@"name":@"中餐"},@{@"icon":@"home_cooking_selected_icon",@"name":@"西餐"},@{@"icon":@"home_westfood_selected_icon",@"name":@"烘培"},@{@"icon":@"home_drink_selected_icon",@"name":@"果饮"}];
    
}

#pragma mark --导航栏图标定位
- (void)setNavIcon {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"home_address_icon"] forState:UIControlStateNormal];
    [button setTitle:@"商丘" forState:UIControlStateNormal];
    [button setTitleColor:LJFontColor61 forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:LJFontSize15];
    [button sizeToFit];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)buttonClick {
    LJLog(@"点击了定位");
}

#pragma mark --configureCollectionView
- (void)configureCollectionView {
    //1.创建流水布局(布局对象)
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //2.创建UICollectionView对象, 将layout添加到collectionViewLayout:里面
    self.LJCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:flowLayout];
    //3.设置UICollectionView基本属性
    self.LJCollectionView.backgroundColor = [UIColor whiteColor];
    self.LJCollectionView.delegate = self;
    self.LJCollectionView.dataSource = self;
    self.LJCollectionView.showsVerticalScrollIndicator = NO;
    //4.注册cell 从上到下顺序
    [self.LJCollectionView registerNib:[UINib nibWithNibName:@"LJMenuItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LJMenuItemCollectionViewCell"];
    [self.LJCollectionView registerNib:[UINib nibWithNibName:@"LJWeDoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LJWeDoCollectionViewCell"];
    [self.LJCollectionView registerNib:[UINib nibWithNibName:@"LJfiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LJfiveCollectionViewCell"];

    //5.注册头部视图
    [self.LJCollectionView registerClass:[NSClassFromString(@"LJCirculyHeaderReusableView") class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJCirculyHeader"];
    [self.LJCollectionView registerClass:[NSClassFromString(@"LJtowCollectionReusableView") class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJtowReusableView"];
    
    [self.view addSubview:self.LJCollectionView];
    
}

#pragma mark --collectionView DataSource
//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
//每组多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 4;
    }else if (section == 3){
        return 8;
    }else if (section == 4){
        return 2;
    }
    return 0;
}
//显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LJMenuItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJMenuItemCollectionViewCell" forIndexPath:indexPath];
        NSDictionary *dic = self.meunArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
        cell.nameLabel.text = dic[@"name"];
        return cell;
    }else if (indexPath.section == 1){
        LJWeDoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJWeDoCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 2){
        LJWeDoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJWeDoCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3){
        LJWeDoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJWeDoCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 4){
        LJfiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJfiveCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
    
}
//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJCirculyHeader" forIndexPath:indexPath];
        return reusableView;
    }else if (indexPath.section == 1){
        LJtowCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJtowReusableView" forIndexPath:indexPath];
        reusableView.titleLabel.text = @"大家都在做";
        return reusableView;
    }else if (indexPath.section == 2){
        LJtowCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJtowReusableView" forIndexPath:indexPath];
        reusableView.titleLabel.text = @"周营养";
        return reusableView;
    }else if (indexPath.section == 3){
        LJtowCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJtowReusableView" forIndexPath:indexPath];
        reusableView.titleLabel.text = @"养生食谱";
        return reusableView;
    }else if (indexPath.section == 4){
        LJtowCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LJtowReusableView" forIndexPath:indexPath];
        reusableView.titleLabel.text = @"特色美食";
        return reusableView;
    }
    return nil;
}

#pragma mark --collectionView Delegate
// 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"%zd",indexPath.item);
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        
    }else if (indexPath.section == 4){
        
    }
    NSLog(@"%zd",indexPath.item);
}

#pragma mark --UICollectionViewDelegateFlowLayout
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {  //menu cell
        return CGSizeMake(SCREEN_WIDTH / 4, 59);
    }else if (indexPath.section == 1){
        return CGSizeMake(SCREEN_WIDTH / 3 - 1, 120);
    }else if (indexPath.section == 2){  //第三个cell 的大小
        return CGSizeMake(77, 100);
    }else if (indexPath.section == 3){ //
        return CGSizeMake(79, 100);
    }else if (indexPath.section == 4){
        return CGSizeMake(SCREEN_WIDTH / 2 - 1, 150);
    }
    return CGSizeMake(30, 30);
}
//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

//动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) { //
        return CGSizeMake(SCREEN_WIDTH, 150);
    }
    return CGSizeMake(SCREEN_WIDTH, 41);
}
//动态设置某组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   if (section == 4) {
        return CGSizeMake(SCREEN_WIDTH, 20);
    }
    return CGSizeMake(0, 0);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

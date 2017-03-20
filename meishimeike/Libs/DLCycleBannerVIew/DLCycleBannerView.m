//
//  DLCycleBannerVIew.m
//  DLCycleBannerVIew
//
//  Created by zhenglong duan on 13/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "DLCycleBannerView.h"
#import "DLCycleBannerViewCell.h"
#import "NSData+DLExtension.h"

@interface DLCycleBannerView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *mainView; //显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount; //总的Item数量
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation DLCycleBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

#pragma mark --初始化
- (void)initialization {
    _pageControlAliment = DLCyleBannerViewPageControlAlimentRight;
    _autoScrollTimeInterval = 2.0;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _isShowPageControl = YES;
    _pageControlStyle = DLCyleBannerViewPageControlStyleClassic;
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark --设置显示图片的collectionView
- (void)setupMainView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[DLCycleBannerViewCell class] forCellWithReuseIdentifier:@"DLCycleBannerViewCell"];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

#pragma mark -- 属性 Set方法
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _flowLayout.itemSize = self.frame.size;
}

- (void)setIsShowPageControl:(BOOL)isShowPageControl {
    _isShowPageControl = isShowPageControl;
    _pageControl.hidden = _isShowPageControl;
}

- (void)setPageControlColor:(UIColor *)pageControlColor {
    _pageControlColor = pageControlColor;
    _pageControl.currentPageIndicatorTintColor = _pageControlColor;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    [self removeTimer];
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageControlStyle:(DLCyleBannerViewPageControlStyle)pageControlStyle {
    _pageControlStyle = pageControlStyle;
    [self setupPageControl];
}

- (void)setLocaliztionImagesArray:(NSArray *)localiztionImagesArray {
    _localiztionImagesArray = localiztionImagesArray;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:localiztionImagesArray.count];
    for (int i = 0; i < localiztionImagesArray.count;  i++) {
        UIImage *image = [UIImage imageNamed:localiztionImagesArray[i]];
        [images addObject:image];
    }
    self.imagesArray = images;
    [self.mainView reloadData];
}

- (void)setURLStringImagesArray:(NSArray *)URLStringImagesArray {
    _URLStringImagesArray = URLStringImagesArray;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:URLStringImagesArray.count];
    for (int i = 0; i < URLStringImagesArray.count; i++) {
        UIImage *image = [[UIImage alloc] init];
        [images addObject:image];
    }
    self.imagesArray = images;
    [self loadImageWithURLStringImagesArray:URLStringImagesArray];
}

- (void)setImagesArray:(NSMutableArray *)imagesArray {
    _imagesArray = imagesArray;
    _totalItemsCount = self.infiniteLoop ? self.imagesArray.count * 100 : self.imagesArray.count;
    if (_imagesArray.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else {
        self.mainView.scrollEnabled = NO;
    }
    [self setupPageControl];
    [self.mainView reloadData];
}

#pragma mark --加载网络图片
- (void)loadImageWithURLStringImagesArray:(NSArray *)URLStringImagesArray {
    for (int  i = 0; i < URLStringImagesArray.count; i++) {
        [self loadimageAtIndex:i];
    }
}

- (void)loadimageAtIndex:(NSInteger)index {
    NSString *urlStr = self.URLStringImagesArray[index];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData getDataCacheWithSubPath:@"DLCycleBannerView" Identifier:urlStr];
    if (data) { //如果缓存中存在，就直接加载缓存
        [self.imagesArray setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
    }else {
       NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                if (!image)  return ; // 防止错误数据导致崩溃
                [self.imagesArray setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
                dispatch_async(dispatch_get_main_queue(),^{
                    if (index == 0) {
                        [self.mainView reloadData]; //主队列里更新UI
                    }
                });
                [data saveDataCacheWithSubPath:@"DLCycleBannerView" Identifier:url.absoluteString];
            }else { //数据加载失败，重新加载
                static int repeat = 0;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (repeat > 10) return ;
                    [self loadimageAtIndex:index];
                    repeat++;
                });
            }
        }];
        [task resume]; //要开启任务
    }
}

#pragma mark --设置分页控件
- (void)setupPageControl {
    if (_pageControl) [_pageControl removeFromSuperview]; //先移除原有的，避免重新加载数据造成错误
    switch (self.pageControlStyle) {
        case DLCyleBannerViewPageControlStyleClassic:
            _pageControl = [[UIPageControl alloc] init];
            _pageControl.numberOfPages = self.imagesArray.count;
            _pageControl.currentPageIndicatorTintColor = self.pageControlColor;
            [self addSubview:_pageControl];
            break;
            
        default:
            break;
    }
}

#pragma mark --自动轮播
- (void)automaticScroll {
    if (_totalItemsCount == 0) return;
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark -- 计时器
- (void)setupTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = self.frame.size;
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    CGSize Size = CGSizeMake(self.imagesArray.count * 5, 15);
    CGFloat x = self.frame.size.width / 2 - Size.width / 2;
    if (self.pageControlAliment == DLCyleBannerViewPageControlAlimentRight) {
        x = self.frame.size.width - Size.width - 50;
    }
    _pageControl.frame = CGRectMake(x, self.frame.size.height - Size.height, Size.width, 15);
    _pageControl.hidden = !_isShowPageControl;
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self removeTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}


#pragma mark - public actions
- (void)clearCache {
    [NSData clearCacheWithSubPath:@"DLCycleBannerView"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DLCycleBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DLCycleBannerViewCell" forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imagesArray.count;
    UIImage *image = self.imagesArray[itemIndex];
    if (image.size.width == 0 && self.placeholderImage) {
        image = self.placeholderImage;
    }
    cell.imageView.image = image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(cycleBannerView:didSelectItemAtIndex:)]) {
        [self.delegate cycleBannerView:self didSelectItemAtIndex:indexPath.item % self.imagesArray.count];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int itemIndex = (scrollView.contentOffset.x + self.mainView.frame.size.width * 0.5) / self.mainView.frame.size.width;
    if (!self.imagesArray.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl = itemIndex % self.imagesArray.count;
    _index = indexOnPageControl;
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = indexOnPageControl;
    if ([self.delegate respondsToSelector:@selector(indexOnPageControl:)]) {
        [self.delegate indexOnPageControl:indexOnPageControl];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self setupTimer];
    }
}
@end

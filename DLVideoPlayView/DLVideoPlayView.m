
//
//  DLVideoPlayView.m
//  DLVideoPlayView
//
//  Created by zhenglong duan on 22/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "DLVideoPlayView.h"
#import "UIView+LJExtension.h"
#import "RotationScreen.h"
/*** 宏定义 ***/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LJColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LJCommonBgColor LJColorFromRGB(0xf3f3f3)


@interface DLVideoPlayView () {
    /*** BOOL类型 ***/
    BOOL _isPlaying; // 播放状态
    BOOL _isLock;    // 是否锁屏
    BOOL _isShowToolbar; // 是否显示工具条
    BOOL _isSliding; // 是否正在滑动
}
/*** 基本属性 ***/
// AVPlayer 控制视频播放
@property (nonatomic, strong) AVPlayer *player;
// AVPlayerLayer 显示播放
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
// AVPlayerItem 视频包含信息
@property (nonatomic,strong) AVPlayerItem *playerItem;
//播放按钮
@property (nonatomic,strong) UIButton *playButton;

/*** 顶部工具条 ***/
@property (nonatomic,strong) UIView *topToolBarView;
   //顶部工具条上的控件
@property (nonatomic,strong) UIButton *backBtn; // 返回键

@property (nonatomic,strong) UIView *bottomToolBarView; //底部工具条
   ///底部工具条上的控件
@property (nonatomic,strong) UISlider *playSlider; //播放滑块
@property (nonatomic,strong) UIProgressView *playProgress; //缓冲进度
@property (nonatomic,strong) UILabel *timeLabel; //播放时长和总时长
@property (nonatomic,strong) UIButton *rotationButton; //大小屏转换
/*** 总时长字符 ***/
@property (nonatomic,strong) NSString *totalTime;

@end

@implementation DLVideoPlayView

- (void)removeObserveAndNOtification {
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    //    [_player removeTimeObserver:_playTimeObserver];
    //    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LJCommonBgColor;
        [self.layer addSublayer:self.playerLayer];
        [self addSubview:self.topToolBarView];
        [self addSubview:self.bottomToolBarView];
        [self addSubview:self.playButton];
        [self showToolBar]; //初始化时显示工具栏
        _isLoadResource = NO; //初始化资源未加载
    }
    return self;
}

#pragma mark --布局
- (void)layoutSubviews {
    [super layoutSubviews];
    _topToolBarView.frame = CGRectMake(0, 0, self.lj_width, 35);
    _bottomToolBarView.frame = CGRectMake(0, self.lj_height - 35, self.lj_width, 35);
    //顶部工具栏
    _backBtn.lj_x = 10;;
    _backBtn.lj_centerY = _topToolBarView.lj_height / 2;
    _titleLabel.lj_x = _backBtn.lj_right + 10;
    _titleLabel.lj_centerY = _backBtn.lj_centerY;
    _collectBtn.lj_right = _topToolBarView.lj_right - 20;
    _collectBtn.lj_centerY = _backBtn.lj_centerY;
    //底部工具栏
    _rotationButton.lj_right = _bottomToolBarView.lj_right - 10;
    _rotationButton.lj_centerY = _bottomToolBarView.lj_height / 2;
    _timeLabel.lj_right = _rotationButton.lj_x - 5;
    _timeLabel.lj_centerY = _rotationButton.lj_centerY;
    
    _playSlider.frame = CGRectMake(5, 0, self.lj_width * 2 / 3, 20);
    _playSlider.lj_centerY = _bottomToolBarView.lj_height / 2;
    _playProgress.frame = CGRectMake(5, 0, self.lj_width * 2 / 3, 20);
    _playProgress.lj_centerY = _bottomToolBarView.lj_height / 2;
    [_titleLabel sizeToFit];
    //AVPlayerLayer
    _playerLayer.frame = self.bounds;
    //播放按钮
    _playButton.lj_centerX = self.lj_width / 2;
    _playButton.lj_centerY = self.lj_height / 2;
}

#pragma mark --播放地址
- (void)playVideoWithURL {
    //为了显示预览图
    self.playerItem = [AVPlayerItem playerItemWithURL:self.URLStr];
    [_player replaceCurrentItemWithPlayerItem:self.playerItem];
}

#pragma mark --添加观察者 、通知 、监听播放进度
- (void)addObserverAndNotification {
    //观察status属性
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 观察缓冲进度
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self monitoringPlayback];// 观察播放进度
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark --// 观察播放进度
- (void)monitoringPlayback {
    __weak typeof(self)weakSelf = self;
    // 播放进度, 每秒执行
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (_TouchPlayerViewMode  != TouchPlayerViewModeSwipingHorizontal) {
            // 当前播放秒
            float currentPlayTime = (double)_playerItem.currentTime.value/ _playerItem.currentTime.timescale;
            // 更新slider, 如果正在滑动则不更新
            if (_isSliding == NO) {
                weakSelf.playSlider.value = currentPlayTime;
                NSString *timeStr = [weakSelf calculateTime:currentPlayTime];
                weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeStr,weakSelf.totalTime];
            }
        }else {
            //水平滑动
            return ;
        }
    }];
}

#pragma mark --视频播放完成通知
- (void)playbackFinished:(NSNotification *)notification {
    [_player seekToTime:CMTimeMake(0, 1)]; // 跳转到初始
    [self playVideo];
}

#pragma mark --KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayerItem *Item = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] integerValue];
        if (status == AVPlayerStatusReadyToPlay) {
            [self playVideo];  //开始播放
            self.playSlider.maximumValue = CMTimeGetSeconds(Item.duration); //设置滑块的最大值，也是视频的总时长
            _totalTime = [self calculateTime:CMTimeGetSeconds(Item.duration)];
            _timeLabel.text = [NSString stringWithFormat:@"00:00/%@",_totalTime]; //设置总时间
        }else if (status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        } else {
            NSLog(@"AVPlayerStatusUnknown");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        //缓冲时间
        NSTimeInterval timeInterval = [self progressDuration];
        CGFloat totalDuration = CMTimeGetSeconds(Item.duration); //总时间
        [self.playProgress setProgress:timeInterval / totalDuration animated:YES]; //进度条时间
    }
}

#pragma mark --计算时间秒数 换算成时间
- (NSString *)calculateTime:(NSInteger)currentTime {
    NSInteger min = (NSInteger)(currentTime%3600)/60;
    NSInteger second = (NSInteger)currentTime%60;
    NSString *timeStr = [NSString stringWithFormat:@"%02zd:%02zd",min,second];
    return timeStr;
}

#pragma mark --已缓冲进度
- (NSTimeInterval)progressDuration {
     // 获取item的缓冲数组
    NSArray *progressArray = [_playerItem loadedTimeRanges];
    // CMTimeRange 结构体 start , duration 表示起始位置 和 持续时间
    CMTimeRange timeRange = [[progressArray firstObject] CMTimeRangeValue];
    NSTimeInterval timeInterval = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
    return timeInterval;
}

#pragma mark --工具栏
/*** 显示工具栏 ***/
- (void)showToolBar {
    _isShowToolbar = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _topToolBarView.alpha = 1;
        _bottomToolBarView.alpha = 1;
        _playButton.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenToolBar];
    });
}
/*** 隐藏工具栏 ***/
- (void)hiddenToolBar {
    _isShowToolbar = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _topToolBarView.alpha = 0;
        _bottomToolBarView.alpha = 0;
        _playButton.alpha = 0;
    }];
}

#pragma mark --播放、暂停
/*** 播放 ***/
- (void)playVideo {
    _isPlaying = YES;
    [_player play];
    [_playButton setImage:[UIImage imageNamed:@"home_play_icon"] forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenToolBar];
    });
}
/*** 暂停 ***/
- (void)pauseVideo {
    _isPlaying = NO;
    [_player pause]; //暂停
    [_playButton setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
}

#pragma mark --控件懒加载
- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//视频填充模式
    }
    return _playerLayer;
}
- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}


//顶部工具条
- (UIView *)topToolBarView {
    if (!_topToolBarView) {
        _topToolBarView = [[UIView alloc] init];
        _topToolBarView.backgroundColor = LJColorFromRGB(0x555555);
        _topToolBarView.alpha = 0;
        [_topToolBarView addSubview:self.backBtn];
        [_topToolBarView addSubview:self.titleLabel];
        [_topToolBarView addSubview:self.collectBtn];
    }
    return _topToolBarView;
}
//返回
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"icmpv_back_light"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn sizeToFit];
    }
    return _backBtn;
}
//标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"美人鱼大战";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}
//收藏
- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [[UIButton alloc] init];
        [_collectBtn setImage:[UIImage imageNamed:@"home_shoucang_icon"] forState:UIControlStateNormal];
        [_collectBtn sizeToFit];
    }
    return _collectBtn;
}


//底部工具条
- (UIView *)bottomToolBarView {
    if (!_bottomToolBarView) {
        _bottomToolBarView = [[UIView alloc] init];
        _bottomToolBarView.backgroundColor = LJColorFromRGB(0x555555);
        _bottomToolBarView.alpha = 0;
        [_bottomToolBarView addSubview:self.playProgress];
        [_bottomToolBarView addSubview:self.playSlider];
        [_bottomToolBarView addSubview:self.timeLabel];
        [_bottomToolBarView addSubview:self.rotationButton];
    }
    return _bottomToolBarView;
}
//播放滑块
- (UISlider *)playSlider {
    if (!_playSlider) {
        _playSlider = [[UISlider alloc] init];
       // _playSlider.tintColor = [UIColor clearColor];
        _playSlider.value = 0.0;
        _playSlider.maximumTrackTintColor = [UIColor clearColor];
        [_playSlider setThumbImage:[UIImage imageNamed:@"icmpv_thumb_light"] forState:UIControlStateNormal];
        [_playSlider addTarget:self action:@selector(SliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_playSlider addTarget:self action:@selector(SliderTouchInside:) forControlEvents:UIControlEventTouchUpInside];
        [_playSlider addTarget:self action:@selector(SliderTouchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _playSlider;
}
//缓冲进度
- (UIProgressView *)playProgress {
    if (!_playProgress) {
        _playProgress = [[UIProgressView alloc] init];
        _playProgress.progress = 0.0; //(0~1)
        _playProgress.progressTintColor = LJColorFromRGB(0xff2e55);
        _playProgress.trackTintColor = LJCommonBgColor;
    }
    return _playProgress;
}
//时间
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = @"00:00/00:00  ";
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}
//大小屏切换
- (UIButton *)rotationButton {
    if (!_rotationButton) {
        _rotationButton = [[UIButton alloc] init];
        [_rotationButton setImage:[UIImage imageNamed:@"player_fullScreen_iphone@2x"] forState:UIControlStateNormal];
        [_rotationButton addTarget:self action:@selector(rotationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rotationButton sizeToFit];
    }
    return _rotationButton;
}
//播放按钮
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_playButton setImage:[UIImage imageNamed:@"home_play_icon"] forState:UIControlStateNormal];
        _playButton.alpha = 0;
        [_playButton sizeToFit];
    }
    return _playButton;
}

#pragma mark --sizeClass 横竖屏切换时，执行
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
        // 横竖屏判断
    if (self.traitCollection.verticalSizeClass != UIUserInterfaceSizeClassCompact) { // 竖屏
        if (self.viewbackframe) {
            self.viewbackframe(self);
        }
    } else { // 横屏
        self.lj_y = 0;
        self.lj_width = SCREEN_WIDTH;
        self.lj_height = SCREEN_HEIGHT;
        [self layoutIfNeeded];
    }
}

#pragma mark -- 所有点击事件
/*** 大小屏切换 ***/
- (void)rotationButtonClick:(UIButton *)sender {
    if ([RotationScreen isOrientationLandscape]) { //如果是横屏
        [RotationScreen forceOrientation:(UIInterfaceOrientationPortrait)]; // 切换为竖屏
    } else {
        [RotationScreen forceOrientation:(UIInterfaceOrientationLandscapeRight)]; // 否则，切换为横屏
    }
}
/*** 返回点击事件 ***/
- (void)backClick:(UIButton *)sender {
    [RotationScreen forceOrientation:(UIInterfaceOrientationPortrait)]; // 切换为竖屏
}

/*** 暂停、播放 ***/
- (void)playButtonClick:(UIButton *)sender {
    if (_isLoadResource == NO) {
        self.playerItem = [AVPlayerItem playerItemWithURL:self.URLStr];
        [_player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self addObserverAndNotification]; //添加观察者 、通知 、监听播放进度
        _isLoadResource = YES;
    }else {
        if (!_isPlaying) {
            [self playVideo];//播放
        }else {
            [self pauseVideo];//暂停
        }
    }
}

#pragma mark --滑块事件
- (void)SliderTouchDown:(UIButton *)sender {
    [self pauseVideo];
}

- (void)SliderTouchInside:(UIButton *)sender {
    _isSliding = NO; //滑动结束
    [self playVideo];
}

- (void)SliderTouchValueChanged:(UIButton *)sender {
    _isSliding = YES; //正在拖动中
    [self pauseVideo];
    CMTime changeTime = CMTimeMake(self.playSlider.value, 1.0);
    [_playerItem seekToTime:changeTime];
}

#pragma mark --屏幕点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _TouchPlayerViewMode = TouchPlayerViewModeTap;  //确定为点击事件
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_TouchPlayerViewMode == TouchPlayerViewModeTap) {  //为点击事件
        if (_isShowToolbar) {
            //隐藏工具栏
            [self hiddenToolBar];
        }else {
            //显示工具栏
            [self showToolBar];
        }
    }
}

@end

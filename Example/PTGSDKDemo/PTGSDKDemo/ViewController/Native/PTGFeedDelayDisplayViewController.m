//
//  PTGFeedDelayDisplayViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/5/19.
//

#import "PTGFeedDelayDisplayViewController.h"
#import "PTGFeedRenderCell.h"
#import <Masonry/Masonry.h>

@interface PTGFeedDelayDisplayViewController ()<PTGNativeExpressAdDelegate,PTGFeedRenderCellDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd;
@property(nonatomic,strong)UIView *nativeAdView;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,assign)BOOL renderSuccess;
@property(nonatomic,strong)UIButton *playButton;
@property(nonatomic,strong)UIButton *pauseButton;

@end

@implementation PTGFeedDelayDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.pauseButton];
    self.textField.hidden = true;
    self.statusLabel.frame = CGRectMake(0, CGRectGetMinY(self.showButton.frame) - 40, UIScreen.mainScreen.bounds.size.width, 30);
    [self.view addSubview:self.statusLabel];
    
//    [self.navigationController.view addSubview:self.maskView];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [self.maskView addGestureRecognizer:pan];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(self.showButton);
        make.bottom.equalTo(self.showButton.mas_top).offset(-10);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(self.showButton);
        make.bottom.equalTo(self.pauseButton.mas_top).offset(-10);
    }];

}

- (void)dealloc {
    [self.maskView removeFromSuperview];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取手势在视图中的偏移量
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    // 更新视图位置
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
    pan.view.center = center;
    
    // 重置手势的偏移量，避免累加效果
    [pan setTranslation:CGPointZero inView:pan.view.superview];
}

- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    [self.manager loadAd];
}

- (void)showAd:(UIButton *)sender {
    
    if (!self.renderSuccess) {
        return;
    }
    
    if (self.nativeAd == nil) { return; }
    [self.nativeAdView removeFromSuperview];
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.nativeAd.isReady) {
        if (self.manager.type == PTGNativeExpressAdTypeFeed) {
            self.nativeAdView = [[UIView alloc] init];
            self.nativeAdView.frame = CGRectMake(0,
                                                 100,
                                                 self.nativeAd.nativeExpressAdView.frame.size.width,
                                                 self.nativeAd.nativeExpressAdView.frame.size.height);
            [self.nativeAdView addSubview:self.nativeAd.nativeExpressAdView];
            [self.view addSubview:self.nativeAdView];
        } else {
            PTGFeedRenderCell *cell = [[PTGFeedRenderCell alloc] init];
            [cell renderAd:self.nativeAd];
            cell.delegate = self;
            self.nativeAdView = cell;
            self.nativeAdView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 200);
            [self.view addSubview:self.nativeAdView];
        }
        self.statusLabel.text = @"广告显示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

- (void)play {
    [self.nativeAd.adObject.relatedView playVideo];
}

- (void)pause {
    [self.nativeAd.adObject.relatedView pauseVideo];
}

- (void)removeAd {
    self.statusLabel.text = @"广告待加载";
    [self.nativeAdView removeFromSuperview];
    self.nativeAd = nil;
    self.nativeAdView = nil;
}

#pragma  mark - PTGFeedRenderCellDelegate -
- (void)renderAdView:(PTGFeedRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    [self.nativeAdView removeFromSuperview];
    self.nativeAd = nil;
    NSLog(@"信息流广告将要被关闭");

}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    self.renderSuccess = NO;
    self.statusLabel.text = @"广告加载成功";
    self.playButton.hidden = ads.firstObject.isNativeExpress;
    self.pauseButton.hidden = ads.firstObject.isNativeExpress;
    self.nativeAd = ads.firstObject;
    [self.nativeAd render];
    [self.nativeAd setController:self];
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"信息流广告加载失败，%@",error);
    self.renderSuccess = NO;
    self.statusLabel.text = @"广告加载失败";
}

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告渲染成功，%@",nativeExpressAd);
    self.renderSuccess = YES;
    self.statusLabel.text = @"广告渲染成功";
}

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"ad = %@",nativeExpressAd);
    NSLog(@"信息流广告渲染失败，%@",error);
    self.renderSuccess = NO;
    [self removeAd];
    self.statusLabel.text = @"广告渲染失败";
//    [self.tableView reloadData];
}

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告曝光");
}

/// 广告显示失败，广告资源过期（媒体缓存广告，广告展示时，广告资源已过期）
/// @param nativeExpressAd 展示失败的广告
/// 展示失败后，请移除广告，如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"信息流广告曝光失败 error = %@",error);
    [self removeAd];
}

/// 原生模板将被点击了
/// @param nativeExpressAd  被点击的模板广告
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告被点击");
}

///  原生模板广告被关闭了
/// @param nativeExpressAd 要关闭的模板广告
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    [self removeAd];
    NSLog(@"信息流广告将要被关闭");
}

/// 原生模板广告将要展示详情页
/// @param nativeExpressAd  广告
- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告展示详情页");
}

/// 原生模板广告将要关闭详情页
/// @param nativeExpressAd 广告
- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告详情页被关闭");
}



- (PTGNativeExpressAdManager *)manager {
    if (!_manager) { //  457 900000231
        PTGNativeExpressAdType type = self.isNativeExpress ? PTGNativeExpressAdTypeFeed : PTGNativeExpressAdTypeSelfRender;
        CGSize size = CGSizeMake(self.view.bounds.size.width, !self.isNativeExpress ? 80 : 200);
        NSString *placementId = !self.isNativeExpress ?  @"900004714" : @"900004471";
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                     type: type
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"广告待加载";
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 500)];
        _maskView.backgroundColor = UIColor.redColor;
    }
    return _maskView;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.backgroundColor = [UIColor lightGrayColor];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseButton.backgroundColor = [UIColor lightGrayColor];
        [_pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseButton;
}


@end

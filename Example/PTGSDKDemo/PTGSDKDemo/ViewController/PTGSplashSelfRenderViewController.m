//
//  PTGSplashSelfRenderViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/3/5.
//

#import "PTGSplashSelfRenderViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import <Masonry/Masonry.h>
#import "PTGSplashSelfRenderView.h"
@interface PTGSplashSelfRenderViewController ()<PTGNativeExpressAdDelegate,PTGSplashSelfRenderViewDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)UIButton *loadButton;
@property(nonatomic,strong)UIButton *showButton;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)PTGSplashSelfRenderView *renderView;

@end

@implementation PTGSplashSelfRenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewsAndLayout];
    
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.statusLabel];
    
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-150);
    }];
    
}

- (void)loadAdAction:(UIButton *)sender {
    [self.manager loadAd];
    self.statusLabel.text = @"广告加载中";
}

- (void)showAdAction:(UIButton *)sender {
    if (self.nativeAd == nil) { return; }
    
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (!self.nativeAd.isReady) {
        self.statusLabel.text = @"广告已过期";
        return;
    }
    PTGSplashSelfRenderView *renderView = [[PTGSplashSelfRenderView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    renderView.delegate = self;
    [renderView updateUI:self.nativeAd];
    self.renderView = renderView;
    [self.view.window addSubview:renderView];
}

- (PTGNativeExpressAdManager *)manager {
    if (!_manager) {
        CGSize size = CGSizeMake(self.view.bounds.size.width, 200);
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:@"900002906"
                                                                     type:PTGNativeExpressAdTypeSelfRenderSplash
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}

- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton setBackgroundColor:UIColor.lightGrayColor];
        _loadButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton addTarget:self action:@selector(loadAdAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_showButton setTitle:@"展示广告" forState:UIControlStateNormal];
        [_showButton setBackgroundColor:UIColor.lightGrayColor];
        _showButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_showButton addTarget:self action:@selector(showAdAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"广告待加载";
        _statusLabel.textColor = [UIColor blackColor];
    }
    return _statusLabel;
}

- (void)nativeAdViewClosed:(PTGNativeExpressAd *)nativeAd {
    [self ptg_nativeExpressAdViewClosed:nativeAd];
}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    self.statusLabel.text = @"广告加载成功";
    NSLog(@"开屏素材 = %@",ads.firstObject.adMaterial);
    self.nativeAd = ads.firstObject;
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    self.statusLabel.text = @"广告加载失败";
}

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告曝光");
}

/// 广告显示失败，广告资源过期（媒体缓存广告，广告展示时，广告资源已过期）
/// @param nativeExpressAd 展示失败的广告
/// 展示失败后，请移除广告，如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    NSLog(@"信息流广告展示失败 error = %@",error);
    self.nativeAd = nil;
    self.statusLabel.text = @"广告待加载";
    [self.renderView removeFromSuperview];
    self.renderView = nil;
}

/// 原生模板将被点击了
/// @param nativeExpressAd  被点击的模板广告
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告被点击");
    
}

///  原生模板广告被关闭了
/// @param nativeExpressAd 要关闭的模板广告
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    self.nativeAd = nil;
    self.statusLabel.text = @"广告待加载";
    [self.renderView removeFromSuperview];
    self.renderView = nil;
}

/// 原生模板广告将要关闭详情页
/// @param nativeExpressAd 广告
- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告详情页被关闭");
}

- (void)dealloc {
    NSLog(@"释放了 %s",__FUNCTION__);
}


@end

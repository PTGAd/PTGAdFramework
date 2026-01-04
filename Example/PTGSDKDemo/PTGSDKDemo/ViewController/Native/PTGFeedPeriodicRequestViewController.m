//
//  PTGFeedPeriodicRequestViewController.m
//  PTGSDKDemo
//
//  Created by PTG on 2024/01/01.
//  Copyright © 2024 PTG. All rights reserved.
//

#import "PTGFeedPeriodicRequestViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderView.h"

@interface PTGFeedPeriodicRequestViewController () <PTGNativeExpressAdDelegate,PTGFeedRenderViewDelegate>

@property (nonatomic, strong) PTGNativeExpressAdManager *manager;
@property (nonatomic, strong) PTGNativeExpressAd *nativeAd;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSTimer *requestTimer;
@property (nonatomic, assign) NSInteger requestCount;
@property (nonatomic, strong) UIView *nativeAdView;

@end

@implementation PTGFeedPeriodicRequestViewController

- (void)dealloc {
    NSLog(@"[PTGFeedPeriodicRequestViewController] dealloc");
    
    // 停止定时器
    if (self.requestTimer) {
        [self.requestTimer invalidate];
        self.requestTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"信息流周期性请求";
    self.requestCount = 0;
    
    [self setupUI];
    [self startPeriodicRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 页面即将消失时停止定时器
    if (self.requestTimer) {
        [self.requestTimer invalidate];
        self.requestTimer = nil;
    }
}

#pragma mark - UI Setup

- (void)setupUI {
    // 状态标签
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.text = @"准备开始请求广告...";
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.font = [UIFont systemFontOfSize:16];
    self.statusLabel.textColor = [UIColor blackColor];
    [self.statusLabel sizeToFit];
    self.statusLabel.center = self.view.center;
    [self.view addSubview:self.statusLabel];
}

#pragma mark - Periodic Request

- (void)startPeriodicRequest {
    // 立即请求第一次
    [self requestAd];
    
    // 启动定时器，每10秒请求一次
    self.requestTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                         target:self
                                                       selector:@selector(requestAd)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)requestAd {
    self.requestCount++;
    
    NSString *statusText = [NSString stringWithFormat:@"第%ld次请求广告中...", (long)self.requestCount];
    self.statusLabel.text = statusText;
    
    NSLog(@"[PTGFeedPeriodicRequestViewController] %@", statusText);
    
    // 加载广告
    [self.manager loadAd];
}



- (void)showAd:(PTGNativeExpressAd *)ad {
    if (ad == nil) { return; }
    [self.nativeAdView removeFromSuperview];
    self.nativeAd = ad;
    PTGFeedRenderView *view = [[PTGFeedRenderView alloc] init];
    [view renderAd:self.nativeAd];
    view.delegate = self;
    self.nativeAdView = view;
    self.nativeAdView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 200);
    [self.view addSubview:self.nativeAdView];
    
}

- (void)removeAd {
    self.statusLabel.text = @"广告待加载";
    [self.nativeAdView removeFromSuperview];
    self.nativeAd = nil;
    self.nativeAdView = nil;
}


#pragma mark - PTGNativeExpressAdDelegate
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    NSString *statusText = [NSString stringWithFormat:@"第%ld次请求成功，立即显示广告", (long)self.requestCount];
    self.statusLabel.text = statusText;
    self.nativeAd = ads.firstObject;
    [self.nativeAd render];
    [self.nativeAd setController:self];
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"信息流广告加载失败，%@",error);
    NSString *statusText = [NSString stringWithFormat:@"第%ld次请求失败: %@", (long)self.requestCount, error.localizedDescription];
    self.statusLabel.text = statusText;
}

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告渲染成功，%@",nativeExpressAd);
    self.statusLabel.text = @"广告渲染成功";
    [self showAd:nativeExpressAd];
}

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"ad = %@",nativeExpressAd);
    NSLog(@"信息流广告渲染失败，%@",error);
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


#pragma mark - PTGFeedRenderCellDelegate

- (void)renderAdView:(PTGFeedRenderView *)renderView clickClose:(PTGNativeExpressAd *)ad {
    NSLog(@"[PTGFeedPeriodicRequestViewController] 自渲染广告被点击");
}

#pragma mark - Lazy Loading

-  (PTGNativeExpressAdManager *)manager {
    if (!_manager) { //  457 900000231
        PTGNativeExpressAdType type = PTGNativeExpressAdTypeSelfRender;
        CGSize size = CGSizeMake(self.view.bounds.size.width,200);
        NSString *placementId = @"900004714";
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                     type: type
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}



@end

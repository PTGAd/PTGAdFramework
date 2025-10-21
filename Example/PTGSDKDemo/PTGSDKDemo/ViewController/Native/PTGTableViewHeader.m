//
//  UITableViewHeader.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/6/25.
//

#import "PTGTableViewHeader.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderView.h"

@interface PTGTableViewHeader()<PTGFeedRenderViewDelegate,PTGNativeExpressAdDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd;
@property(nonatomic,strong)UIView *nativeAdView;
@property(nonatomic,strong)UILabel *statusLabel;
//@property(nonatomic,strong)UILabel *tipLabel;

@end

@implementation PTGTableViewHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setViewController:(UIViewController *)viewController {
    _viewController = viewController;
    self.manager.currentViewController = viewController;
}

- (void)layoutSubviews {
//    self.tipLabel.frame = self.bounds;
}

- (void)loadAd {
    self.statusLabel.text = @"广告加载中";
    [self.manager loadAd];
}

- (void)showAd {
    if (self.nativeAd == nil) { return; }
    [self.nativeAdView removeFromSuperview];
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.nativeAd.isReady) {
        if (self.manager.type == PTGNativeExpressAdTypeFeed) {
            self.nativeAdView = [[UIView alloc] init];
            self.nativeAdView = self.nativeAd.nativeExpressAdView;
            [self addSubview:self.nativeAdView];
        } else {
            PTGFeedRenderView *view = [[PTGFeedRenderView alloc] initWithFrame: CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 300)];
            [view renderAd:self.nativeAd];
            view.delegate = self;
            self.nativeAdView = view;
            [self addSubview:self.nativeAdView];
        }
        self.statusLabel.text = @"广告显示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
    
//    [self addSubview:self.tipLabel];
}

- (void)removeAd {
    self.statusLabel.text = @"广告待加载";
    [self.nativeAdView removeFromSuperview];
    self.nativeAd = nil;
    self.nativeAdView = nil;
}

#pragma  mark - PTGFeedRenderCellDelegate -
- (void)renderAdView:(PTGFeedRenderView *)view clickClose:(PTGNativeExpressAd *)ad {
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
    self.statusLabel.text = @"广告加载成功";
    self.nativeAd = ads.firstObject;
    [self.nativeAd render];
    [self.nativeAd setController:self.viewController];
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"信息流广告加载失败，%@",error);
    self.statusLabel.text = @"广告加载失败";
}

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告渲染成功，%@",nativeExpressAd);
    self.statusLabel.text = @"广告渲染成功";
    [self showAd];
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
    NSLog(@"@@@@信息流广告曝光 header");
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
        PTGNativeExpressAdType type = PTGNativeExpressAdTypeSelfRender;
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:@"900002888"
                                                                     type: type
                                                                   adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
        _manager.delegate = self;
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

//- (UILabel *)tipLabel {
//    if (!_tipLabel) {
//        _tipLabel = [[UILabel alloc] init];
//        _tipLabel.text = @"header 中的视频广告 可能和cell 中的视频广告同时播放 sdk 内部维护了播放器在cell 中只播放一个视频";
//        _tipLabel.textColor = [UIColor blackColor];
//        _tipLabel.textAlignment = NSTextAlignmentCenter;
//        _tipLabel.numberOfLines = 0;
//        _tipLabel.textColor = [UIColor redColor];
//    }
//    return _tipLabel;
//}


@end

//
//  PTGFeedDelayDisplayViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/5/19.
//

#import "PTGFeedDelayDisplayViewController.h"
#import "PTGFeedRenderCell.h"

@interface PTGFeedDelayDisplayViewController ()<PTGNativeExpressAdDelegate,PTGFeedRenderCellDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd;
@property(nonatomic,strong)UIView *nativeAdView;
@property(nonatomic,strong)UILabel *statusLabel;

@end

@implementation PTGFeedDelayDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.hidden = true;
    self.statusLabel.frame = CGRectMake(0, CGRectGetMinY(self.showButton.frame) - 40, UIScreen.mainScreen.bounds.size.width, 30);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.statusLabel];
}

- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    [self.manager loadAd];
}

- (void)showAd:(UIButton *)sender {
    if (self.nativeAd == nil) { return; }
    [self.nativeAdView removeFromSuperview];
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.nativeAd.isReady) {
        if (self.manager.type == PTGNativeExpressAdTypeFeed) {
            self.nativeAdView = [[UIView alloc] init];
            self.nativeAdView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, self.nativeAd.adHeight);
            [self.nativeAd displayAdToView:self.nativeAdView];
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
    self.statusLabel.text = @"广告加载成功";
    self.nativeAd = ads.firstObject;
    [self.nativeAd render];
    [self.nativeAd setController:self];
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



- (PTGNativeExpressAdManager *)manager {
    if (!_manager) { //  457 900000231
        PTGNativeExpressAdType type = self.isNativeExpress ? PTGNativeExpressAdTypeFeed : PTGNativeExpressAdTypeSelfRender;
        CGSize size = CGSizeMake(self.view.bounds.size.width, !self.isNativeExpress ? 80 : 200);
        NSString *placementId = !self.isNativeExpress ?  @"900002175" : @"900000399";
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

@end

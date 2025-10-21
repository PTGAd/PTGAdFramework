//
//  PTGNativeExpressInScrollViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/6/24.
//

#import "PTGNativeExpressInScrollViewController.h"
#import "PTGFeedRenderCell.h"

@interface PTGNativeExpressInScrollViewController ()<PTGNativeExpressAdDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd1;
@property(nonatomic,strong)PTGNativeExpressAd *nativeAd2;
@property(nonatomic,strong)UIView *nativeAdView1;
@property(nonatomic,strong)UIView *nativeAdView2;
@property(nonatomic,strong)UILabel *statusLabel;


@end

@implementation PTGNativeExpressInScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height * 3);
    self.scrollView.frame = UIScreen.mainScreen.bounds;
    [self.view insertSubview:self.scrollView atIndex:0];
    self.showButton.hidden = YES;
    
    self.textField.hidden = true;
    self.statusLabel.frame = CGRectMake(0, CGRectGetMinY(self.showButton.frame) - 40, UIScreen.mainScreen.bounds.size.width, 30);
    [self.view addSubview:self.statusLabel];
    

}


- (void)removeAd {
    self.statusLabel.text = @"广告待加载";
    [self.nativeAdView1 removeFromSuperview];
    self.nativeAd1 = nil;
    self.nativeAdView1 = nil;
}

- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    [self.manager loadAd];
}

- (void)showAdNative1 {
    [self.nativeAdView1 removeFromSuperview];
    if (self.nativeAd1.isReady) {
        if (self.manager.type == PTGNativeExpressAdTypeFeed) {
            self.nativeAdView1 = [[UIView alloc] init];
            self.nativeAdView1.frame = CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, self.nativeAd1.nativeExpressAdView.frame.size.height);
            [self.nativeAdView1 addSubview:self.nativeAd1.nativeExpressAdView];
            [self.scrollView addSubview:self.nativeAdView1];
        } else {
            PTGFeedRenderCell *cell = [[PTGFeedRenderCell alloc] init];
            [cell renderAd:self.nativeAd1];
            cell.delegate = self;
            self.nativeAdView1 = cell;
            self.nativeAdView1.frame = CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 200);
            [self.scrollView addSubview:self.nativeAdView1];
        }
        self.statusLabel.text = @"广告显示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

- (void)showAdNative2 {
    [self.nativeAdView2 removeFromSuperview];
    if (self.nativeAd2.isReady) {
        if (self.manager.type == PTGNativeExpressAdTypeFeed) {
            self.nativeAdView2 = [[UIView alloc] init];
            self.nativeAdView2.frame = CGRectMake(0, 350, UIScreen.mainScreen.bounds.size.width, self.nativeAd1.nativeExpressAdView.frame.size.height);
            [self.nativeAdView2 addSubview:self.nativeAd1.nativeExpressAdView];
            [self.scrollView addSubview:self.nativeAdView2];
        } else {
            PTGFeedRenderCell *cell = [[PTGFeedRenderCell alloc] init];
            [cell renderAd:self.nativeAd2];
            cell.delegate = self;
            self.nativeAdView2 = cell;
            self.nativeAdView2.frame = CGRectMake(0, 350, UIScreen.mainScreen.bounds.size.width, 200);
            [self.scrollView addSubview:self.nativeAdView2];
        }
        self.statusLabel.text = @"广告显示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}


- (void)renderAdView:(PTGFeedRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    [self removeAd];
}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    self.statusLabel.text = @"广告加载成功";
    if (self.nativeAd1 == nil) {
        self.nativeAd1 = ads.firstObject;
        [self.nativeAd1 render];
        [self.nativeAd1 setController:self];
    } else {
        self.nativeAd2 = ads.firstObject;
        [self.nativeAd2 render];
        [self.nativeAd2 setController:self];
    }

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
    if (nativeExpressAd == self.nativeAd1) {
        [self showAdNative1];
    } else {
        [self showAdNative2];
    }
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
        NSString *placementId = !self.isNativeExpress ?  @"900002888" : @"900003437";
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

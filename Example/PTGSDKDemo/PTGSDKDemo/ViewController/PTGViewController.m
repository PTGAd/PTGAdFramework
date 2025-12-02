//
//  PTGViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/5.
//

#import "PTGViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedViewController.h"
#import "PTGNativeExpressBannerViewController.h"
#import "PTGNativeExpressInterstitialAdViewController.h"
#import "PTGNativeExpressRewardVideoAdViewController.h"
#import "PTGOpenURLViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AdConfigViewController.h"
#import "PTGSplashViewController.h"
#import "ATPTGSplashViewController.h"
#import "ATPTGBannerExpressViewController.h"
#import "ATPTGInterstitialAdViewController.h"
#import "PTGSplashSelfRenderViewController.h"
#import "TGNativeAdController.h"
#import "ATPTGRewardVideoAdViewController.h"
#import "YYCategories/YYCategories.h"


@interface PTGViewController ()
<
PTGSplashAdDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,strong)NSArray<NSString *> *items;
@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CLLocationManager *manager;
//@property(nonatomic,strong)BUNativeExpressSplashView *nativeExpressSplashView;

@end

@implementation PTGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestAlwaysAuthorization];
    [self.manager requestWhenInUseAuthorization];
    self.items = @[
        @"开屏",
        @"开屏自渲染",
        @"信息流",
        @"横幅",
        @"插屏",
        @"激励",
        @"topon开屏",
        @"topon信息流",
        @"topon横幅",
        @"topon插屏",
        @"topon激励",
        @"启用摇一摇,默认启用",
        @"禁用摇一摇",
    ];
    [self addChildViewsAndLayout];
    
//    [self configAdSDK];
    
}

- (void)configAdSDK {
    AdConfigViewController *vc = [AdConfigViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:vc animated:true completion:^{
        
    }];
}


- (void)addChildViewsAndLayout {
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (splashAd.isReady) {
        [splashAd showAdWithViewController:self];
    }
}

/// 开屏加载失败
- (void)ptg_splashAd:(PTGSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"开屏广告请求失败%@",error);
}

/// 开屏广告被点击了
- (void)ptg_splashAdDidClick:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告关闭了
- (void)ptg_splashAdDidClose:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

///  开屏广告将要展示
- (void)ptg_splashAdWillVisible:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

#pragma mark - UITableViewDelegate,UITableViewDataSourc -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        viewController = [[PTGSplashViewController alloc] init];
    } else if(indexPath.row == 1) {
        PTGSplashSelfRenderViewController *vc = [[PTGSplashSelfRenderViewController alloc] init];
        viewController = vc;
    } else if(indexPath.row == 2) {
        PTGFeedViewController *vc = [[PTGFeedViewController alloc] init];
        viewController = vc;
    } else if(indexPath.row == 3) {
        viewController = [[PTGNativeExpressBannerViewController alloc] init];
    } else if(indexPath.row == 4) {
        viewController = [[PTGNativeExpressInterstitialAdViewController alloc] init];
    } else if (indexPath.row == 5) {
        viewController = [[PTGNativeExpressRewardVideoAdViewController alloc] init];
    } else if (indexPath.row == 6) {
        ATPTGSplashViewController *vc = [[ATPTGSplashViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 7) {
        TGNativeAdController *vc = [[TGNativeAdController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 8) {
        ATPTGBannerExpressViewController *vc = [[ATPTGBannerExpressViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 9) {
        ATPTGInterstitialAdViewController *vc = [[ATPTGInterstitialAdViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 10) {
        ATPTGRewardVideoAdViewController *vc = [[ATPTGRewardVideoAdViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 11) {
        [PTGSDKManager setSensorStatus:YES];
    } else if (indexPath.row == 12) {
        [PTGSDKManager setSensorStatus:NO];
    }
 
    viewController ? [self.navigationController pushViewController:viewController animated:YES] : nil;
}

#pragma mark - get -
- (PTGSplashAd *)splashAd {
    if (!_splashAd) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
        bottomView.backgroundColor = [UIColor whiteColor];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
        logo.accessibilityIdentifier = @"splash_logo";
        logo.frame = CGRectMake(0, 0, 311, 47);
        logo.center = bottomView.center;
        [bottomView addSubview:logo];
        
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900000397"];
        _splashAd.delegate = self;
        _splashAd.bottomView = bottomView;
    }
    return _splashAd;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

//- (BUNativeExpressSplashView *)nativeExpressSplashView {
//    if (!_nativeExpressSplashView) {
//        BUAdSlot *slot = [[BUAdSlot alloc] init];
//        slot.ID = @"887494331";
//        slot.splashButtonType = BUSplashButtonType_DownloadBar;
//        _nativeExpressSplashView = [[BUNativeExpressSplashView alloc] initWithSlot:slot adSize:self.view.bounds.size rootViewController:self];
//        _nativeExpressSplashView.delegate = self;
//    }
//    return _nativeExpressSplashView;
//}
//
///**
// This method is called when splash ad material loaded successfully.
// */
//- (void)nativeExpressSplashViewDidLoad:(BUNativeExpressSplashView *)splashAdView {
//
//}
//
///**
// This method is called when splash ad material failed to load.
// @param error : the reason of error
// */
//- (void)nativeExpressSplashView:(BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error {
//
//}
//
///**
// This method is called when rendering a nativeExpressAdView successed.
// */
//- (void)nativeExpressSplashViewRenderSuccess:(BUNativeExpressSplashView *)splashAdView {
//    [self.view addSubview:splashAdView];
//}
//
///**
// This method is called when a nativeExpressAdView failed to render.
// @param error : the reason of error
// */
//- (void)nativeExpressSplashViewRenderFail:(BUNativeExpressSplashView *)splashAdView error:(NSError * __nullable)error {
//
//}
//
///**
// This method is called when nativeExpressSplashAdView will be showing.
// */
//- (void)nativeExpressSplashViewWillVisible:(BUNativeExpressSplashView *)splashAdView {
//
//}
//
///**
// This method is called when nativeExpressSplashAdView is clicked.
// */
//- (void)nativeExpressSplashViewDidClick:(BUNativeExpressSplashView *)splashAdView {
//
//}
//
///**
// This method is called when nativeExpressSplashAdView's skip button is clicked.
// */
//- (void)nativeExpressSplashViewDidClickSkip:(BUNativeExpressSplashView *)splashAdView {
//
//}
///**
// This method is called when nativeExpressSplashAdView countdown equals to zero
// */
//- (void)nativeExpressSplashViewCountdownToZero:(BUNativeExpressSplashView *)splashAdView {
//
//}
//
///**
// This method is called when nativeExpressSplashAdView closed.
// */
//- (void)nativeExpressSplashViewDidClose:(BUNativeExpressSplashView *)splashAdView {
//
//}
//
///**
// This method is called when when video ad play completed or an error occurred.
// */
//- (void)nativeExpressSplashViewFinishPlayDidPlayFinish:(BUNativeExpressSplashView *)splashView didFailWithError:(NSError *)error {
//
//}
//
///**
// This method is called when another controller has been closed.
// @param interactionType : open appstore in app or open the webpage or view video ad details page.
// */
//- (void)nativeExpressSplashViewDidCloseOtherController:(BUNativeExpressSplashView *)splashView interactionType:(BUInteractionType)interactionType {
//
//}

@end

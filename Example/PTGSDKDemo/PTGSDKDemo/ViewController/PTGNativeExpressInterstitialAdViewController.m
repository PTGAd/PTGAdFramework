//
//  PTGNativeExpressInterstitialAdViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeExpressInterstitialAdViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>

@interface PTGNativeExpressInterstitialAdViewController ()<PTGNativeExpressInterstitialAdDelegate>

@property(nonatomic,strong)PTGNativeExpressInterstitialAd *interstitialAd;
@property(nonatomic,strong)UIButton *loadButton;

@end

@implementation PTGNativeExpressInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.loadButton];
  
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
}

#pragma mark - action -
- (void)buttonClicked:(UIButton *)sender {
    [self.interstitialAd loadAd];
}

#pragma mark - PTGNativeExpressInterstitialAdDelegate -
- (void)ptg_nativeExpresInterstitialAdDidLoad:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告加载成功%@",interstitialAd);
    [interstitialAd showAdFromRootViewController:self];
}

- (void)ptg_nativeExpresInterstitialAd:(PTGNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error {
    NSLog(@"插屏广告加载失败%@",error);
}

- (void)ptg_nativeExpresInterstitialAdWillVisible:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告曝光%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDidClick:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告被点击%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDidClose:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告被关闭%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDidCloseOtherController:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告详情页被关闭%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDisplayFail:(PTGNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"插屏广告展示失败%@",interstitialAd);
}

#pragma mark - get -
- (PTGNativeExpressInterstitialAd *)interstitialAd {
    if (!_interstitialAd) {
        _interstitialAd = [[PTGNativeExpressInterstitialAd alloc] initWithPlacementId:@"900000230"];
        _interstitialAd.adSize = CGSizeMake(300, 300);
        _interstitialAd.delegate = self;
    }
    return _interstitialAd;
}

- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton setBackgroundColor:UIColor.lightGrayColor];
        _loadButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (void)dealloc {
    NSLog(@"释放了,%s",__func__);
}


@end

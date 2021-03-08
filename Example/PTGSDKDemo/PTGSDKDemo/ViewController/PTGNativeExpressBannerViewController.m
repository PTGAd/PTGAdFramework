//
//  PTGNativeExpressBannerViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeExpressBannerViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import <Masonry/Masonry.h>

@interface PTGNativeExpressBannerViewController ()<PTGNativeExpressBannerAdDelegate>

@property(nonatomic,strong)PTGNativeExpressBannerAd *bannerAd;
@property(nonatomic,strong)UIButton *loadButton;

@end

@implementation PTGNativeExpressBannerViewController

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
    [self.bannerAd loadAd];
}

#pragma mark - PTGNativeExpressBannerAdDelegate -
///  广告加载成功
///  在此方法中调用 showAdFromView:frame 方法
- (void)ptg_nativeExpressBannerAdDidLoad:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告加载成功%@,",bannerAd);
    [bannerAd showAdFromView:self.view frame:(CGRect){{0,200},bannerAd.realSize}];
}

/// 广告加载失败
- (void)ptg_nativeExpressBannerAd:(PTGNativeExpressBannerAd *)bannerAd didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"横幅广告加载失败%@,",error);
}

/// 广告将要曝光
- (void)ptg_nativeExpressBannerAdWillBecomVisible:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告曝光%@,",bannerAd);
}

/// 广告被点击
- (void)ptg_nativeExpressBannerAdDidClick:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告被点击%@,",bannerAd);
}
 
/// 广告被关闭
- (void)ptg_nativeExpressBannerAdClosed:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告被关闭%@,",bannerAd);
}

/// 广告详情页给关闭
- (void)ptg_nativeExpressBannerAdViewDidCloseOtherController:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告详情页被关闭%@,",bannerAd);
}

#pragma mark - get -
- (PTGNativeExpressBannerAd *)bannerAd {
    if (!_bannerAd) {
        _bannerAd = [[PTGNativeExpressBannerAd alloc] initWithPlacementId:@"900000229" size:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 2.0)];
        _bannerAd.delegate = self;
        _bannerAd.rootViewController = self;
    }
    return _bannerAd;
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

@end

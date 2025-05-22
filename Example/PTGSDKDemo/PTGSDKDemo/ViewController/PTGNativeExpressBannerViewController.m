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
@property(nonatomic,strong)UIButton *winButton;
@property(nonatomic,strong)UIButton *lossButton;
@property(nonatomic,strong)UILabel *statusLabel;

@end

@implementation PTGNativeExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    self.textField.hidden = true;
    [self.view addSubview:self.winButton];
    [self.view addSubview:self.lossButton];
    [self.view addSubview:self.statusLabel];
  
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.left.equalTo(self.winButton);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.right.equalTo(self.lossButton);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    
    [self.winButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.right.equalTo(self.view.mas_centerX).offset(-10);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.lossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.left.equalTo(self.view.mas_centerX).offset(10);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.bottom.equalTo(self.winButton.mas_top).offset(-10);
    }];
    
}

#pragma mark - action -
- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    [self.bannerAd loadAd];
}

- (void)showAd:(UIButton *)sender {
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.bannerAd.isReady) {
        [self.bannerAd showAdFromView:self.view frame:(CGRect){{0,200},self.bannerAd.realSize}];
        self.statusLabel.text = @"广告显示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

- (void)winReport {
    [self.bannerAd notifyBidWin:100.0 secondPrice:95.0];
}

- (void)lossReport {
    PTGBidReason *reason = [PTGBidReason new];
    reason.winPrice = 100;
    reason.winAdnId = PTGADNIDCSJ;
    reason.lossCode = BidLossCodeOther;
    reason.lossOtherReason = @"自定义原因";
    reason.extra = @{
        @"other":@"其他原因"
    };
    [self.bannerAd notifyBidLoss:reason];
}

#pragma mark - PTGNativeExpressBannerAdDelegate -
///  广告加载成功
///  在此方法中调用 showAdFromView:frame 方法
- (void)ptg_nativeExpressBannerAdDidLoad:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告加载成功%@,",bannerAd);
    self.statusLabel.text = @"广告加载成功";
}

/// 广告加载失败
- (void)ptg_nativeExpressBannerAd:(PTGNativeExpressBannerAd *)bannerAd didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"横幅广告加载失败%@,",error);
    self.statusLabel.text = @"广告加载失败";
}

/// 广告将要曝光
- (void)ptg_nativeExpressBannerAdWillBecomVisible:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告曝光%@,",bannerAd);
}

/// 广告曝光失败
- (void)ptg_nativeExpressBannerAdBecomVisibleFail:(PTGNativeExpressBannerAd *)bannerAd error:(NSError *_Nullable)error {
    NSLog(@"横幅广告曝光失败%@, error = %@",bannerAd,error);
}
/// 广告被点击
- (void)ptg_nativeExpressBannerAdDidClick:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告被点击%@,",bannerAd);
}
 
/// 广告被关闭
- (void)ptg_nativeExpressBannerAdClosed:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告被关闭%@,",bannerAd);
    self.statusLabel.text = @"广告待加载";
}

/// 广告详情页给关闭
- (void)ptg_nativeExpressBannerAdViewDidCloseOtherController:(PTGNativeExpressBannerAd *)bannerAd {
    NSLog(@"横幅广告详情页被关闭%@,",bannerAd);
}

#pragma mark - get -
- (PTGNativeExpressBannerAd *)bannerAd {
    if (!_bannerAd) {
        _bannerAd = [[PTGNativeExpressBannerAd alloc] initWithPlacementId:@"900000396" size:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 90 / 600.0)];
        _bannerAd.delegate = self;
        _bannerAd.rootViewController = self;
    }
    return _bannerAd;
}

- (UIButton *)winButton {
    if (!_winButton) {
        _winButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_winButton setTitle:@"竞胜上报" forState:UIControlStateNormal];
        [_winButton setBackgroundColor:UIColor.lightGrayColor];
        _winButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_winButton addTarget:self action:@selector(winReport) forControlEvents:UIControlEventTouchUpInside];
    }
    return _winButton;
}

- (UIButton *)lossButton {
    if (!_lossButton) {
        _lossButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_lossButton setTitle:@"竞败上报" forState:UIControlStateNormal];
        [_lossButton setBackgroundColor:UIColor.lightGrayColor];
        _lossButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_lossButton addTarget:self action:@selector(lossReport) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lossButton;
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

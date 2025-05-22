//
//  PTGSplashViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/10/27.
//

#import "PTGSplashViewController.h"

@interface PTGSplashViewController ()<PTGSplashAdDelegate>

@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)UILabel *statusLabel;

@end

@implementation PTGSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"请输入广告id，默认900000397";
    self.textField.text = @"900000397";
    [self.view addSubview:self.statusLabel];
    
    self.statusLabel.frame = CGRectMake(0, CGRectGetMinY(self.showButton.frame) - 40, UIScreen.mainScreen.bounds.size.width, 30);
}


- (void)loadAd:(UIButton *)sender {
    if ([self.splashAd.placementId isEqualToString:self.textField.text]) {
        [_splashAd loadAd];
        return;
    }
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    [bottomView addSubview:logo];
    
    NSString *placementId = self.textField.text.length > 0 ? self.textField.text : @"900000397";
    _splashAd = [[PTGSplashAd alloc] initWithPlacementId:placementId];
    _splashAd.delegate = self;
    _splashAd.bottomView = bottomView;
    [_splashAd loadAd];
    self.statusLabel.text = @"广告加载中";
}

- (void)showAd:(UIButton *)sender {
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.splashAd.isReady) {
        [self.splashAd showAdWithViewController:self];
    } else {
        self.statusLabel.text = @"广告已过期";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view.window endEditing:false];
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    self.statusLabel.text = @"广告加载成功";
}

/// 开屏加载失败
- (void)ptg_splashAd:(PTGSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"开屏广告请求失败%@",error);
    self.statusLabel.text = @"广告加载失败";
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

- (void)ptg_splashAdVisibleError:(PTGSplashAd *)splashAd error:(NSError *)error {
    NSLog(@"开屏广告展示失败%s error = %@",__func__,error);
}

- (void)ptg_splashAdDetailDidClose:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告详情页关闭%s",__func__);
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

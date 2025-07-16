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
@property(nonatomic,strong)UITextField *numberTextField;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UISwitch *on;
@property(nonatomic,strong)UILabel *onLabel;

@end

@implementation PTGNativeExpressInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.textField.text = @"900000398";
    self.numberTextField.text = @"3";
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.textField];
    [self.view addSubview:self.numberTextField];
    [self.view addSubview:self.on];
    [self.view addSubview:self.onLabel];
    self.shakeTextFiled.hidden = true;
    
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(300, 40));
        make.top.equalTo(self.textField.mas_bottom).offset(20);
    }];
    
    [self.on mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberTextField.mas_bottom).offset(10);
        make.left.equalTo(self.numberTextField);
    }];
    
    [self.onLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.on);
        make.left.equalTo(self.on.mas_right).offset(10);
    }];
    
    
    self.statusLabel.frame = CGRectMake(0, CGRectGetMinY(self.showButton.frame) - 40, UIScreen.mainScreen.bounds.size.width, 30);
    [self.view addSubview:self.statusLabel];

}

- (void)eventValueChanged:(UISwitch *)sender {
    self.interstitialAd.closeAfterClick = sender.on;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

#pragma mark - action -
- (void)loadAd:(UIButton *)sender {
    self.statusLabel.text = @"广告加载中";
    if ([self.interstitialAd.placementId isEqualToString:self.textField.text]) {
        [self.interstitialAd loadAd];
        return;
    }
    NSString *placementId = self.textField.text.length == 0 ? @"900000398" : self.textField.text;
    self.interstitialAd = [[PTGNativeExpressInterstitialAd alloc] initWithPlacementId:placementId];
    self.interstitialAd.adSize = CGSizeMake(200, 300);
    self.interstitialAd.delegate = self;
//    self.interstitialAd.closeAfterClick = YES;
    [self.interstitialAd loadAd];
    NSLog(@"interstitialAd = %@",self.interstitialAd);
}

- (void)showAd:(UIButton *)sender {
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (self.interstitialAd.isReady) {
        [self.interstitialAd showAdFromRootViewController:self];
        self.statusLabel.text = @"广告展示中";
    } else {
        self.statusLabel.text = @"广告已过期";
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.interstitialAd closureInterstitialAd];
    });
}

#pragma mark - PTGNativeExpressInterstitialAdDelegate -
- (void)ptg_nativeExpresInterstitialAdDidLoad:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告加载成功%@",interstitialAd);
    self.statusLabel.text = @"广告加载成功";
}

- (void)ptg_nativeExpresInterstitialAd:(PTGNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error {
    NSLog(@"插屏广告加载失败%@",error);
    self.statusLabel.text = @"广告加载失败";
}

- (void)ptg_nativeExpresInterstitialAdWillVisible:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告曝光%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdVisibleFail:(PTGNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"插屏广告展示失败 error = %@",error);
    self.statusLabel.text = @"广告展示失败";
}

- (void)ptg_nativeExpresInterstitialAdDidClick:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告被点击%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDidClose:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告被关闭%@",interstitialAd);
    self.statusLabel.text = @"广告待加载";
}

- (void)ptg_nativeExpresInterstitialAdDidCloseOtherController:(PTGNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"插屏广告详情页被关闭%@",interstitialAd);
}

- (void)ptg_nativeExpresInterstitialAdDisplayFail:(PTGNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"插屏广告展示失败%@ error = %@",interstitialAd,error);
}

- (UITextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc] init];;
        _numberTextField.borderStyle = UITextBorderStyleRoundedRect;
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _numberTextField;
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

- (UILabel *)onLabel {
    if (!_onLabel) {
        _onLabel = [[UILabel alloc] init];
        _onLabel.text = @"点击后关闭插屏";
        _onLabel.textColor = [UIColor blackColor];
        _onLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _onLabel;
}

- (UISwitch *)on {
    if (!_on) {
        _on = [[UISwitch alloc] init];
        [_on addTarget:self action:@selector(eventValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _on;
}


- (void)dealloc {
    NSLog(@"释放了,%s",__func__);
}


@end

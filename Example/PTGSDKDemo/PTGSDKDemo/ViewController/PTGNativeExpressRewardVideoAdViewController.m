//
//  PTGNativeExpressRewardVideoAdViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeExpressRewardVideoAdViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import <Masonry/Masonry.h>

@interface PTGNativeExpressRewardVideoAdViewController ()<PTGRewardVideoDelegate>

@property(nonatomic,strong)PTGNativeExpressRewardVideoAd *rewardVideoAd;
@property(nonatomic,strong)UIButton *loadButton;
@property(nonatomic,strong)UIButton *showButton;
@property(nonatomic,strong)UILabel *statusLabel;

@end

@implementation PTGNativeExpressRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.showButton];
    [self.view addSubview:self.statusLabel];
  
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-160);
    }];
}
#pragma mark - action -
- (void)buttonClicked:(UIButton *)sender {
    self.statusLabel.text = @"开始加载";
    [self.rewardVideoAd loadAd];
}

- (void)showClicked:(UIButton *)sender {
    if (self.rewardVideoAd.isReady) {
        [self.rewardVideoAd showAdFromRootViewController:self];
    } else {
        self.statusLabel.text = @"广告已过期";
    }
   
}

#pragma makr - PTGRewardVideoDelegate -
/// 激励广告加载成功
/// 在此方法中调用showAdFromRootViewController 展示激励广告
- (void)ptg_rewardVideoAdDidLoad:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    self.statusLabel.text = @"加载成功";
    NSLog(@"激励广告素材 = %@",rewardVideoAd.adMaterial);
    NSLog(@"激励广告加载成功%@",rewardVideoAd);
//    [rewardVideoAd showAdFromRootViewController:self];
}

/// 激励广告失败 加载失败 播放失败 渲染失败
- (void)ptg_rewardVideoAd:(PTGNativeExpressRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error {
    NSLog(@"激励广告加载失败%@",error);
    self.statusLabel.text = @"广告加载失败";
}

/// 激励广告将要展示
- (void)ptg_rewardVideoAdWillVisible:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告将要展示%@",rewardVideoAd);
}

- (void)ptg_rewardVideoAdExposedFail:(PTGNativeExpressRewardVideoAd *)rewardVideoAd error:(NSError *)error {
    NSLog(@"激励广告曝光失败%@",error);
}

/// 激励广告曝光
- (void)ptg_rewardVideoAdDidExposed:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告曝光%@",rewardVideoAd);
}

/// 激励广告关闭
- (void)ptg_rewardVideoAdDidClose:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    self.statusLabel.text = @"未加载";
    NSLog(@"激励广告关闭%@",rewardVideoAd);
}

/// 激励广告被点击
- (void)ptg_rewardVideoAdDidClicked:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告被点击%@",rewardVideoAd);
}

/// 激励广告播放完成
- (void)ptg_rewardVideoAdDidPlayFinish:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告播放完成%@",rewardVideoAd);
}

- (void)ptg_rewardVideoAdDidRewardEffective:(PTGNativeExpressRewardVideoAd *)rewardedVideoAd isVerify:(BOOL)isVerify {
    NSLog(@"激励广告达到激励条件%@ isVerify = %d",rewardedVideoAd,isVerify);
}

#pragma mark - get -
- (PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    if (!_rewardVideoAd) {
//        PTGRewardedVideoModel *model = [PTGRewardedVideoModel new];
//        model.rewardName = @"奖励名称";
//        model.rewardAmount = 400;
        _rewardVideoAd = [[PTGNativeExpressRewardVideoAd alloc] initWithPlacementId:@"900002904" rewardedVideoModel:nil];
        _rewardVideoAd.delegate = self;
    }
    return _rewardVideoAd;
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

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_showButton setTitle:@"展示广告" forState:UIControlStateNormal];
        [_showButton setBackgroundColor:UIColor.lightGrayColor];
        _showButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_showButton addTarget:self action:@selector(showClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"广告待加载";
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = [UIColor blackColor];
    }
    return _statusLabel;
}

@end

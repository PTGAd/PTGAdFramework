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

@end

@implementation PTGNativeExpressRewardVideoAdViewController

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
    [self.rewardVideoAd loadAd];
}

#pragma makr - PTGRewardVideoDelegate -
/// 激励广告加载成功
/// 在此方法中调用showAdFromRootViewController 展示激励广告
- (void)ptg_rewardVideoAdDidLoad:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告加载成功%@",rewardVideoAd);
    [rewardVideoAd showAdFromRootViewController:self];
}

/// 激励广告失败 加载失败 播放失败 渲染失败
- (void)ptg_rewardVideoAd:(PTGNativeExpressRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error {
    NSLog(@"激励广告加载失败%@",error);
}

/// 激励广告将要展示
- (void)ptg_rewardVideoAdWillVisible:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告将要展示%@",rewardVideoAd);
}

/// 激励广告曝光
- (void)ptg_rewardVideoAdDidExposed:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    NSLog(@"激励广告曝光%@",rewardVideoAd);
}

/// 激励广告关闭
- (void)ptg_rewardVideoAdDidClose:(PTGNativeExpressRewardVideoAd *)rewardVideoAd {
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

- (void)ptg_rewardVideoAdDidRewardEffective:(PTGNativeExpressRewardVideoAd *)rewardedVideoAd {
    NSLog(@"激励广告达到激励条件%@",rewardedVideoAd);
}

#pragma mark - get -
- (PTGNativeExpressRewardVideoAd *)rewardVideoAd {
    if (!_rewardVideoAd) {
        _rewardVideoAd = [[PTGNativeExpressRewardVideoAd alloc] initWithPlacementId:@"900000400"];
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

@end

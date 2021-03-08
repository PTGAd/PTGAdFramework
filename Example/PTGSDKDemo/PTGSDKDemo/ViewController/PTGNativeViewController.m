//
//  PTGNativeRenderViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/18.
//

#import "PTGNativeViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import <Masonry/Masonry.h>

@interface PTGNativeViewController ()<PTGNativeAdDelegate,PTGNativeAdViewDelegate>

@property(nonatomic,strong)PTGNativeAd *nativeAd;
@property(nonatomic,strong)UIButton *loadButton;

@end

@implementation PTGNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loadButton];
  
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    if (self.type == 6) {
        self.nativeAd.type = PTGNativeAdTypeTextFlip;
    } else if (self.type == 7) {
        self.nativeAd.type = PTGNativeAdTypeTextScroll;
    } else if (self.type == 8) {
        // 此种类型的广告不允许修改视图大小
        self.nativeAd.type = PTGNativeAdTypeBrandCard;
    }
}

- (void)buttonClicked:(UIButton *)sender {
    [self.nativeAd loadAd];
}

#pragma mark - PTGNativeAdDelegate -
- (void)ptg_nativeAdDidLoad:(PTGNativeAd *)nativeAd view:(PTGNativeAdView *)adView {
    adView.viewController = self;
    adView.delegate = self;
    [adView render];
    [self.view addSubview:adView];

    if (self.type == 6 || self.type == 7) {
        adView.frame = CGRectMake(100, 100, 200, 20);
    } else if (self.type == 8) {                            //
        adView.frame = CGRectMake(100, 100, 200, 200);
    }
    NSLog(@"个性化模板广告加载成功，%s",__func__);
}

- (void)ptg_nativeAd:(PTGNativeAd *)nativeAd didFailWithError:(NSError *)error {
    NSLog(@"个性化模板广告加载失败，%s",__func__);
}

/**
 广告曝光回调
 
 */
- (void)ptg_nativeAdViewWillExpose:(PTGNativeAdView *)adView {
    NSLog(@"个性化模板广告曝光，%s",__func__);
}

/**
 广告点击回调
 */
- (void)ptg_nativeAdViewDidClick:(PTGNativeAdView *)adView {
    NSLog(@"个性化模板广告点击，%s",__func__);
}


/**
 广告详情页关闭回调
 */
- (void)ptg_nativeAdDetailViewClosed:(PTGNativeAdView *)adView {
    NSLog(@"个性化模板广告详情页关闭，%s",__func__);
}

/**
 广告详情页面即将展示回调
 
 */
- (void)ptg_nativeAdDetailViewWillPresentScreen:(PTGNativeAdView *)adView {
    NSLog(@"个性化模板广告详情页展示，%s",__func__);
}


#pragma mark - get - 
- (PTGNativeAd *)nativeAd {
    if (!_nativeAd) {
        _nativeAd = [[PTGNativeAd alloc] initWithPlacementId:@"460"];
        _nativeAd.delegate = self;
    }
    return _nativeAd;
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

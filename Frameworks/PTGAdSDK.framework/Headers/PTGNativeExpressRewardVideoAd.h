//
//  PTGNativeExpressRewardVideoAd.h
//  lottie-ios_Oc
//
//  Created by admin on 2021/1/26.
//

#import <UIKit/UIkit.h>
@class PTGNativeExpressRewardVideoAd;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGRewardVideoDelegate <NSObject>
@optional
/// 激励广告加载成功
- (void)ptg_rewardVideoAdDidLoad:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 激励广告失败 加载失败 播放失败 渲染失败
- (void)ptg_rewardVideoAd:(PTGNativeExpressRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error;

/// 激励广告将要展示
- (void)ptg_rewardVideoAdWillVisible:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 激励广告曝光
- (void)ptg_rewardVideoAdDidExposed:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 激励广告关闭
- (void)ptg_rewardVideoAdDidClose:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 激励广告被点击
- (void)ptg_rewardVideoAdDidClicked:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 激励广告播放完成
- (void)ptg_rewardVideoAdDidPlayFinish:(PTGNativeExpressRewardVideoAd *)rewardVideoAd;

/// 达到激励条件
- (void)ptg_rewardVideoAdDidRewardEffective:(PTGNativeExpressRewardVideoAd *)rewardedVideoAd;

@end

@interface PTGNativeExpressRewardVideoAd : NSObject

/// 广告id
@property(nonatomic,copy,readonly)NSString *placementId;

/// 激励广告代理
@property(nonatomic,weak)id<PTGRewardVideoDelegate> delegate;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

///  初始化 
/// @param placementId 广告id
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;

/// 展示激励广告
/// @param controller 控制器 一般为当前控制器 或者栈顶控制器
- (void)showAdFromRootViewController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END

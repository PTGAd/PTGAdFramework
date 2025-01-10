//
//  PTGNativeExpressInterstitialAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/21.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGSourceAdType.h>
#import <PTGAdSDK/PTGBidReason.h>
@class PTGNativeExpressInterstitialAd;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGNativeExpressInterstitialAdDelegate <NSObject>

- (void)ptg_nativeExpresInterstitialAdDidLoad:(PTGNativeExpressInterstitialAd *)interstitialAd;

- (void)ptg_nativeExpresInterstitialAd:(PTGNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error;

- (void)ptg_nativeExpresInterstitialAdWillVisible:(PTGNativeExpressInterstitialAd *)interstitialAd;

- (void)ptg_nativeExpresInterstitialAdDidClick:(PTGNativeExpressInterstitialAd *)interstitialAd;

- (void)ptg_nativeExpresInterstitialAdDidClose:(PTGNativeExpressInterstitialAd *)interstitialAd;

- (void)ptg_nativeExpresInterstitialAdDidCloseOtherController:(PTGNativeExpressInterstitialAd *)interstitialAd;

- (void)ptg_nativeExpresInterstitialAdDisplayFail:(PTGNativeExpressInterstitialAd *)interstitialAd error:(NSError *)error;

@end

@interface PTGNativeExpressInterstitialAd : NSObject

@property(nonatomic,weak)id<PTGNativeExpressInterstitialAdDelegate> delegate;

/// 支持的广告尺寸：1:1、2:3、3:2 三种尺寸  部分消耗方不依赖于广告位尺寸
/// 为避免渲染过程产生广告视图形变，插屏广告的请求尺寸务必和媒体平台配置相同尺寸
@property(nonatomic,assign)CGSize adSize;

/// 单位分
@property(nonatomic,assign)NSInteger ecpm;

/// 广告id
@property(nonatomic,copy,readonly)NSString *placementId;

/// 消耗方类型
@property(nonatomic,assign)PTGAdSourceType sourceType;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

///  初始化 
/// @param placementId 广告id
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;

/// 展示插屏广告
/// @param controller 控制器 一般为当前控制器 或者栈顶控制器
- (void)showAdFromRootViewController:(UIViewController *)controller;

/// 主动关闭插屏 当前只支持fancy 消耗方
- (void)closureInterstitialAd;

/// 通知广告平台的广告竞胜
///  @param costPrice 竞胜价格
///  @param secondPrice 二价
- (void)notifyBidWin:(double)costPrice secondPrice:(double)secondPrice;
/// 通知广告平台的广告竞败
/// @param bidLossReason 竞败原因
- (void)notifyBidLoss:(PTGBidReason *)bidLossReason;

@end

NS_ASSUME_NONNULL_END

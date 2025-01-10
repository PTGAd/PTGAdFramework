//
//  PTGNativeExpressFullscreenVideoAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGSourceAdType.h>
#import <PTGAdSDK/PTGBidReason.h>
@class PTGNativeExpressFullscreenVideoAd;

NS_ASSUME_NONNULL_BEGIN


@protocol PTGNativeExpressFullscreenVideoAdDelegate <NSObject>

@optional
/// 广告加载成功
/// @param fullscreenVideoAd 广告实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidLoad:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/// 广告加载实例
/// @param fullscreenVideoAd 广告实例
/// @param error 错误
- (void)ptg_nativeExpressFullscreenVideoAd:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/// 渲染成功
/// @param fullscreenVideoAd 广告实例
- (void)ptg_nativeExpressFullscreenVideoAdViewRenderSuccess:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/// 广告渲染失败
/// @param fullscreenVideoAd 广告实例
/// @param error 错误
- (void)ptg_nativeExpressFullscreenVideoAdViewRenderFail:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/// 全屏视频广告已经展示
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidVisible:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/// 全屏视频广告点击
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidClick:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

///全屏视频广告关闭
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidClose:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/// 全屏视频广告详情页关闭
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidCloseOtherController:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

///  全屏视频广告播放失败
- (void)ptg_nativeExpressFullscreenVideoAdDidPlayFinish:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

@end

@interface PTGNativeExpressFullscreenVideoAd : NSObject

/// 代理对象
@property(nonatomic,weak)id<PTGNativeExpressFullscreenVideoAdDelegate> delegate;

/// 消耗方类型
@property(nonatomic,assign)PTGAdSourceType sourceType;

/// 广告ecpm  单位分
@property(nonatomic,assign)NSInteger ecpm;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

/// 初始化方法
/// @param placementId 广告id
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;

/// 展示广告稿】
/// @param rootViewController 当前控制器
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

/// 通知广告平台的广告竞胜
///  @param costPrice 竞胜价格
///  @param secondPrice 二价
- (void)notifyBidWin:(double)costPrice secondPrice:(double)secondPrice;
/// 通知广告平台的广告竞败
/// @param bidLossReason 竞败原因
- (void)notifyBidLoss:(PTGBidReason *)bidLossReason;

@end

NS_ASSUME_NONNULL_END

//
//  OneAdSDK
//
//  Created by guangkuo.zgk on 2024/10/30.
//  Copyright © 2024 fanti.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OneAdSDK/FTAdBidProtocol.h>
#import <OneAdSDK/FTAdInfoObject.h>

NS_ASSUME_NONNULL_BEGIN
@class FTSplashAd;
@protocol FTSplashAdDelegate<NSObject>

@optional

/// 开屏广告素材加载成功
- (void)splashAdLoadSuccess:(FTSplashAd *)splashAd;

/// 开屏广告素材加载失败
- (void)splashAdLoadFail:(FTSplashAd *)splashAd error:(NSError *_Nullable)error;

/// 开屏广告素材渲染成功
- (void)splashAdRenderSuccess:(FTSplashAd *)splashAd;

/// 开屏广告素材渲染失败
- (void)splashAdRenderFail:(FTSplashAd *)splashAd error:(NSError *_Nullable)error;

/// 开屏广告展示成功
- (void)splashAdDidShow:(FTSplashAd *)splashAd;

/// 开屏广告点击
- (void)splashAdDidClick:(FTSplashAd *)splashAd;

/// 开屏广告点击关闭
- (void)splashAdDidClose:(FTSplashAd *)splashAd;

/// 开屏广告倒计时结束或者非点击关闭场景
- (void)splashAdDidFinish:(FTSplashAd *)splashAd;

/// 开屏广告视频播放完成或者报错.
- (void)splashVideoAdDidPlayFinish:(FTSplashAd *)splashAd didFailWithError:(NSError *_Nullable)error;

/**
 * 开屏广告剩余时间回调
 */
- (void)splashAdCountdownTime:(NSUInteger)time;
@end

@interface FTSplashAd : NSObject<FTAdBidProtocol>
/// 媒体id
@property (nonatomic, copy, nullable) NSString *mediaId;
/// 应用id
@property (nonatomic, copy, nonnull) NSString *appId;
/// 代码位id
@property (nonatomic, copy, nonnull) NSString *slotId;

/**
 可传入自定义底部视图，需要设置视图宽高
 key:kBottomView  value:UIView
 */
@property (nonatomic, copy, nullable) NSDictionary *extInfo;

@property (nonatomic, weak) id<FTSplashAdDelegate> delegate;

/**
 请求广告数据并展示
 */
- (void)loadAndShowSplashViewInRootViewController:(UIViewController *)viewController;

/**
 请求广告数据
 */
- (void)loadAdData;

/**
 展示开屏广告
 请在广告素材加载成功之后调用，即splashAdLoadSuccess回调之后
 */
- (void)showSplashViewInRootViewController:(UIViewController *)viewController;
/**
 获取广告价格，单位：分
 请在广告素材加载成功之后调用，即splashAdLoadSuccess回调之后
 */
- (NSString *)getECPM;

@end


NS_ASSUME_NONNULL_END

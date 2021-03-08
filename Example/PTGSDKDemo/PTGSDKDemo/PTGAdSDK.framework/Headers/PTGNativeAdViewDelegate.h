//
//  PTGNativeAdViewDelegate.h
//  PTGAdSDK
//
//  Created by admin on 2021/2/20.
//

#import <Foundation/Foundation.h>
@class PTGNativeAdView;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGNativeAdViewDelegate <NSObject>
@optional;
/**
 广告曝光回调
 
 */
- (void)ptg_nativeAdViewWillExpose:(PTGNativeAdView *)adView;

/**
 广告点击回调
 */
- (void)ptg_nativeAdViewDidClick:(PTGNativeAdView *)adView;

/**
 广告详情页关闭回调
 */
- (void)ptg_nativeAdDetailViewClosed:(PTGNativeAdView *)adView;

/**
 广告详情页面即将展示回调
 
 */
- (void)ptg_nativeAdDetailViewWillPresentScreen:(PTGNativeAdView *)adView;

@end



NS_ASSUME_NONNULL_END

//
//  PTGnativeAd.h
//  CocoaDebug
//
//  Created by admin on 2021/2/18.
//

#import <UIKit/UIKit.h>
@class PTGNativeAd;
@class PTGNativeAdView;

typedef enum : NSUInteger {
    PTGNativeAdTypeBrandCard      = 0,
    PTGNativeAdTypeTextFlip       = 1,
    PTGNativeAdTypeTextScroll     = 2,
} PTGNativeAdType;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGNativeAdDelegate <NSObject>

/// 广告数据加载成功
/// @param nativeAd 广告
/// @param adView  广告视图
- (void)ptg_nativeAdDidLoad:(PTGNativeAd *)nativeAd view:(PTGNativeAdView *)adView;

/// 广告加载失败
- (void)ptg_nativeAd:(PTGNativeAd *)nativeAd didFailWithError:(NSError *)error;

@end

@interface PTGNativeAd : NSObject

@property(nonatomic,copy,readonly)NSString *placementId;

@property(nonatomic,weak)id<PTGNativeAdDelegate> delegate;

/// 必选 广告的展示类型 默认PTGNativeAdTypeBrandCard
@property(nonatomic,assign)PTGNativeAdType type;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

///  初始化
/// @param placementId 广告id
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;


@end

NS_ASSUME_NONNULL_END

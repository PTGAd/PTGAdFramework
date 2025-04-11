//
//  PTGNativeExpressAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/16.
//

#import <Foundation/Foundation.h>
#import "PTGNativeExpressAd.h"
#import <PTGAdSDK/PTGBidReason.h>
@class PTGNativeExpressAdManager;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PTGNativeExpressAdTypeDraw,  // draw视频信息流
    PTGNativeExpressAdTypeSelfRender, // 自渲染
    PTGNativeExpressAdTypeFeed,  // 普通模板信息流
    PTGNativeExpressAdTypeSelfRenderSplash // 自渲染开屏
} PTGNativeExpressAdType;


@protocol PTGNativeExpressAdDelegate <NSObject>
@optional;

/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads;

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error;

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd;

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error;

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd;

/// 原生模板将被点击了
/// @param nativeExpressAd  被点击的模板广告
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd;

///  原生模板广告被关闭了
/// @param nativeExpressAd 要关闭的模板广告
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd;

/// 原生模板广告将要展示详情页
/// @param nativeExpressAd  广告
- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd;

/// 原生模板广告将要关闭详情页
/// @param nativeExpressAd 广告
- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd;

@end

@interface PTGNativeExpressAdManager : NSObject

@property(nonatomic,weak)id<PTGNativeExpressAdDelegate> delegate;

@property(nonatomic,weak)UIViewController *currentViewController;

@property(nonatomic,assign,readonly)PTGNativeExpressAdType type;

/// 最新的一条广告的ecpm
@property(nonatomic,assign,readonly)NSInteger ecpm;


/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

/// 初始化方法
/// @param placementId 广告id
/// @param type 广告type
/// @param adSize 广告尺寸,PTGNativeExpressAdTypeFeed 类型根据宽度自适应，可将高度直接设置为0 PTGNativeExpressAdTypeDraw类型传入屏幕的宽高
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId type:(PTGNativeExpressAdType)type adSize:(CGSize)adSize NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;

/// 通知广告平台的广告竞胜
///  @param costPrice 竞胜价格
///  @param secondPrice 二价
- (void)notifyBidWin:(double)costPrice secondPrice:(double)secondPrice;
/// 通知广告平台的广告竞败
/// @param bidLossReason 竞败原因
- (void)notifyBidLoss:(PTGBidReason *)bidLossReason;

@end

NS_ASSUME_NONNULL_END

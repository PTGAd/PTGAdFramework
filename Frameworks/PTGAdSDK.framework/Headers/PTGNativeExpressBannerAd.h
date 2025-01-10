//
//  PTGNativeExpressBannerAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/25.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGSourceAdType.h>
#import <PTGAdSDK/PTGBidReason.h>
@class PTGNativeExpressBannerAd;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGNativeExpressBannerAdDelegate <NSObject>
@optional

///  广告加载成功
///  在此方法中调用 showAdFromView:frame 方法
- (void)ptg_nativeExpressBannerAdDidLoad:(PTGNativeExpressBannerAd *)bannerAd;

/// 广告加载失败
- (void)ptg_nativeExpressBannerAd:(PTGNativeExpressBannerAd *)bannerAd didLoadFailWithError:(NSError *_Nullable)error;

/// 广告将要曝光
- (void)ptg_nativeExpressBannerAdWillBecomVisible:(PTGNativeExpressBannerAd *)bannerAd;

/// 广告被点击
- (void)ptg_nativeExpressBannerAdDidClick:(PTGNativeExpressBannerAd *)bannerAd;
 
/// 广告被关闭
- (void)ptg_nativeExpressBannerAdClosed:(PTGNativeExpressBannerAd *)bannerAd;

/// 广告详情页给关闭
- (void)ptg_nativeExpressBannerAdViewDidCloseOtherController:(PTGNativeExpressBannerAd *)bannerAd;

@end

@interface PTGNativeExpressBannerAd : NSObject

/// 广告id
@property(nonatomic,copy,readonly)NSString *placementId;

/// 广告的实际size 
@property(nonatomic,assign,readonly)CGSize realSize;

/// 【必选参数】 广告的代理
@property(nonatomic,weak)id<PTGNativeExpressBannerAdDelegate> delegate;

/// 【必选参数】根控制器 一般为当前控制器
@property(nonatomic,weak)UIViewController *rootViewController;

/// 消耗方类型
@property(nonatomic,assign)PTGAdSourceType sourceType;

/// ecpm 单位分
@property(nonatomic,assign,readonly)NSInteger ecpm;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

///  初始化 
/// @param placementId 广告id
/// 支持的广告位宽高比：2:1、3:2、6:5、30:13、20:3、4:1、6.4:1、345:194、161 : 70共9个尺寸，开发者按照展示场景进行勾选。创建好的尺寸不支持修改
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId size:(CGSize)size NS_DESIGNATED_INITIALIZER;

/// 加载广告
- (void)loadAd;

/// 展示广告 此处传入的frame 此处frame的size 应该与初始化时传入的size一致
- (void)showAdFromView:(UIView *)view frame:(CGRect)frame;

/// 通知广告平台的广告竞胜
///  @param costPrice 竞胜价格
///  @param secondPrice 二价
- (void)notifyBidWin:(double)costPrice secondPrice:(double)secondPrice;
/// 通知广告平台的广告竞败
/// @param bidLossReason 竞败原因
- (void)notifyBidLoss:(PTGBidReason *)bidLossReason;

@end

NS_ASSUME_NONNULL_END

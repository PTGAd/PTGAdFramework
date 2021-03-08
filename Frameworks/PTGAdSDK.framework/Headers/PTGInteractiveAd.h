//
//  PTGInteractiveAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/2/25.
//

#import <UIKit/UIKit.h>
@class PTGInteractiveAd;

NS_ASSUME_NONNULL_BEGIN

@protocol PTGInteractiveAdDelegate <NSObject>

///  广告加载成功 广告场景内的广告加载成功
- (void)ptg_interactiveAdDidLoad:(PTGInteractiveAd *)interactiveAd;

/// 广告加载失败 广告场景内的广告加载失败
- (void)ptg_interactiveAd:(PTGInteractiveAd *)interactiveAd didLoadFailWithError:(NSError *_Nullable)error;

/// 广告将要曝光 广告场景内的广告将要展示
- (void)ptg_interactiveAdWillBecomVisible:(PTGInteractiveAd *)interactiveAd;

/// 广告被点击  广告场景内的广告被点击
- (void)ptg_interactiveAdDidClick:(PTGInteractiveAd *)interactiveAd;
 
/// 广告被关闭 广告场景内的广告被关闭
- (void)ptg_interactiveAdClosed:(PTGInteractiveAd *)interactiveAd;

/// 广告详情页给关闭 广告场景内的广告详情页被关闭
- (void)ptg_interactiveAdViewDidCloseOtherController:(PTGInteractiveAd *)interactiveAd;

///  互动广告页面关闭 广告场景被关闭
- (void)ptg_interactiveAdClosedAdPage:(PTGInteractiveAd *)interactiveAd;

@end

@interface PTGInteractiveAd : NSObject

@property(nonatomic,weak)id<PTGInteractiveAdDelegate> delegate;

/// 必须 当前控制器
@property(nonatomic,weak)UIViewController *viewController;

/// 广告id
@property(nonatomic,copy,readonly)NSString *placementId;

/// 禁止使用此方法来初始化
+ (instancetype)new NS_UNAVAILABLE;

/// 禁止使用此方法来初始化
- (instancetype)init NS_UNAVAILABLE;

///  初始化
/// @param placementId 广告id
- (instancetype)initWithPlacementId:(nonnull NSString *)placementId NS_DESIGNATED_INITIALIZER;

/// 打开互动广告页面 此方法并不会加载广告 只是打开广告的场景
- (void)openAdPage;

@end

NS_ASSUME_NONNULL_END

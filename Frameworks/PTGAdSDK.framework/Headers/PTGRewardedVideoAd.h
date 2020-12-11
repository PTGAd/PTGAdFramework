//
//  PTGRewardedVideoAd.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/17.
//

#import <Foundation/Foundation.h>
#import "PTGAdvertising.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PTGRewardedVideoAdDelegate <NSObject>

@optional


/**
 广告数据加载成功回调

 @param rewardedVideoAd NSObject 实例
 */
- (void)rewardVideoAdDidLoad:(NSObject *)rewardedVideoAd;

///**
// 视频数据下载成功回调，已经下载过的视频会直接回调
//
// @param rewardedVideoAd NSObject 实例
// */
- (void)rewardVideoAdVideoDidLoad:(NSObject *)rewardedVideoAd;

/**
 视频播放页即将展示回调

 @param rewardedVideoAd NSObject 实例
 */
- (void)rewardVideoAdWillVisible:(NSObject *)rewardedVideoAd;


/**
 视频播放页关闭回调

 @param rewardedVideoAd NSObject 实例
 */
- (void)rewardVideoAdDidClose:(NSObject *)rewardedVideoAd;

/**
 视频广告信息点击回调

 @param rewardedVideoAd NSObject 实例
 */
- (void)rewardVideoAdDidClicked:(NSObject *)rewardedVideoAd;

/**
 视频广告各种错误信息回调

 @param rewardedVideoAd NSObject 实例
 @param error 具体错误信息
 */
- (void)rewardVideoAd:(NSObject *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 视频广告视频播放完成

 @param rewardedVideoAd NSObject 实例
 */
- (void)rewardVideoAdDidPlayFinish:(NSObject *)rewardedVideoAd;


/**
 视频广告播放达到激励条件回调

 @param rewardedVideoAd GDTRewardVideoAd 实例
 */
- (void)rewardVideoAdDidRewardEffective:(NSObject *)rewardedVideoAd;

@end

@interface PTGRewardedVideoAd : PTGAdvertising

@property (nonatomic, weak) id <PTGRewardedVideoAdDelegate> delegate;

/**
构造方法
@param placementId 广告位ID
*/
- (instancetype)initWithPlacementId:(NSString *)placementId;


/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 */
- (void)showRootViewController:(UIViewController *)rootViewController;


/**
*
*  数据加载的时候使用
*
*/
- (void)loadAdData;

@end

NS_ASSUME_NONNULL_END

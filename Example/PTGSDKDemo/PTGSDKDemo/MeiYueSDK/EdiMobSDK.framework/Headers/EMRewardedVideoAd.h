//
//  MYRewardedVideoAd.h
//  MYAdsSDK
//
//  Created by liudehan on 2018/7/16.
//  Copyright © 2018年 King_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EdiMobSDK/EMAdsProtocol.h>

@protocol EMRewardedVideoAdDelagate;
@class EMRewardedVideoModel;

@interface EMRewardedVideoAd : NSObject<EMAdsProtocol>

@property (nonatomic, strong) EMRewardedVideoModel *rewardVieoModel;

@property (nonatomic, weak) id<EMRewardedVideoAdDelagate> delegate;

/**
 * 构造方法

 @param slotId 广告位id
 @param model 激励视频Model
 @return 激励视频对象
 */
- (instancetype)initWithSlotId:(NSString *)slotId andRewardModel:(EMRewardedVideoModel *)model;

/**
 * 加载数据
 */
- (void)EM_loadAdData;

/**
 展示
 @param rootViewController 将要弹出的视图控制器
 */
- (void)EM_showAdFromRootViewController:(UIViewController *)rootViewController;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;

@end

@protocol EMRewardedVideoAdDelagate <NSObject>

@optional
/**
 rewardedVideoAd 激励视频广告素材加载成功 
 
 */
- (void)EM_rewardedVideoAdDidLoad;

/**
 rewardedVideoAd 广告位即将展示
 
 */
- (void)EM_rewardedVideoAdWillVisible;

/**
 rewardedVideoAd 激励视频广告关闭
 
 */
- (void)EM_rewardedVideoAdDidClose;

/**
 rewardedVideoAd 激励视频广告点击下载

 */
- (void)EM_rewardedVideoAdDidClickDownload;

/**
 rewardedVideoAd 激励视频广告素材加载失败
 @param error 错误对象
 */
- (void)EM_rewardedVideoAdDidFailWithError:(NSError *)error;

/**
 校验后的结果
 
 @param rewardedVideoAd 当前激励视频Model
 @param verify 有效性验证结果
 */
- (void)EM_rewardedVideoAdServerRewardDidSucceed:(EMRewardedVideoModel *)rewardedVideoAd verify:(BOOL)verify;

@end


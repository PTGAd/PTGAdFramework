//
//  PTGRewardedVideoModel.h
//  PTGAdSDK
//
//  Created by yongjiu on 2025/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGRewardedVideoModel : NSObject

/**
 可选。
 第三方游戏用户 ID 标识。
 主要用于奖励发放，是服务端到服务端回调的透传参数。
 它是每个用户的唯一标识。
 在非服务端回调模式下，视频播放结束后也会透传。
 此参数只能传入字符串，不能传入 nil。
 */
@property (nonatomic, copy, nullable) NSString *userId;

/**
 可选。序列化字符串。(json)
 */
@property (nonatomic, copy, nullable) NSString *extra;
/**
 奖励名称
 */
@property (nonatomic, copy, nullable) NSString *rewardName;

/**
 奖励数量
 */
@property (nonatomic, assign) NSInteger rewardAmount;

@end

NS_ASSUME_NONNULL_END

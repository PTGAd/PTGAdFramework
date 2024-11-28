//
//  MYRewardedVideoModel.h
//  MYAdsSDK
//
//  Created by liudehan on 2018/7/16.
//  Copyright © 2018年 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMRewardedVideoModel : NSObject

/**
 * 第三方游戏 user_id 标识，必传 (主要是用于奖励判定过程中，服务器到服务器回调透传的参数，是游戏对用户的唯一标识；非服务器回调模式在视频播完回调时也会透传给游戏应用)
 */
@property (nonatomic, copy) NSString *userId;

/**
 * 奖励名称，可选
 */
@property (nonatomic, copy) NSString *rewardName;

/**
 * 奖励数量，可选
 */
@property (nonatomic, assign) NSInteger rewardAmount;

/**
 * 序列化后的字符串，可选
 */
@property (nonatomic, copy) NSString *extra;


@end

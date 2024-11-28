//
//  MeiYueSDKConfig.h
//
//  Created by liudehan on 2018/7/3.
//  Copyright © 2018年 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMSDKConfig : NSObject

/// 如果不允许使用IDFA请设置为YES
@property (nonatomic, assign) BOOL nonIDFA;

/**
 *  配置类单例
 */
+ (instancetype)shareInstance;

/**
 *  初始化配置信息(必选)
 */
- (void)initConfigWithAppId:(NSString *)appId;

/**
 SDK版本号
 
 @return SDK版本号
 */
- (NSString *)sdkVersion;

/**
是否允许定位

@param enabled 默认为NO
*/
- (void)enableGPS:(BOOL)enabled;

/**
 设置个性化推荐状态
 @param state 1为关闭个性化推荐，其他值或未设置为打开
 */
- (void)setPersonalizedState:(NSInteger)state;

/// 外部媒体通过该接口传递IDFA，如果不允许传@""
/// @param idfa 外部传入的idfa
- (void)setSDKIDFA:(NSString *)idfa;

@end

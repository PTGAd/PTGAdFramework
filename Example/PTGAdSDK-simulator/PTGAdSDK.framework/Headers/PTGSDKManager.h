//
//  PTGSDKManager.h
//  PTGAdSDK
//
//  Created by admin on 2020/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGSDKManager : NSObject

+ (NSString *)getSDKVersion;

+ (NSString *)getDeviceIdentifier;

/// 广告标识ids  只接受key 为 caid，idfa，ali_aaid的值，有建议传递，对广告填充有影响
+ (void)setAdIds:(NSDictionary<NSString *,NSString *> *)adIds;
/// 获取传入的adids
+ (NSDictionary<NSString *,NSString *> *)adIds;

/// 请求广告前必须调用此方法设置appKey appSecret
/// @param appKey 平台上申请的appKey
/// @param appSecret 平台上申请的appSecret
/// @param completion 设置完成后的回调
+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret completion:(void(^)(BOOL result,NSError * error))completion;

@end

NS_ASSUME_NONNULL_END

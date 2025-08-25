//
//  PTGSDKManager.h
//  PTGAdSDK
//
//  Created by admin on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGSDKManager : NSObject

+ (NSString *)getSDKVersion;

+ (NSString *)getDeviceIdentifier;

///广告标识ids
+ (void)setAdIds:(NSDictionary<NSString *,NSString *> *)adIds;

+ (NSDictionary<NSString *,NSString *> *)adIds;

/// 是否开启摇一摇的监听，默认开启，不开启就不出摇一摇样式广告
+ (void)setSensorStatus:(BOOL)status;

///设置广告logo（Fancy支持）
+ (void)setAdLogo:(UIImage *)adLogo;

/// 同步设置 appKey appSecret 2.2.74版本之后支持 建议使用同步方法
/// @param appKey 平台上申请的appKey
/// @param appSecret 平台上申请的appSecret
+ (BOOL)syncSetAppKey:(NSString *)appKey appSecret:(NSString *)appSecret;

/// 请求广告前必须调用此方法设置appKey appSecret
/// @param appKey 平台上申请的appKey
/// @param appSecret 平台上申请的appSecret
/// @param completion 设置完成后的回调
/// 新版本建议使用同步方法初始化
+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret completion:(void(^)(BOOL result,NSError * error))completion;

@end

NS_ASSUME_NONNULL_END

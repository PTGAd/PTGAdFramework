//
//  PTGAdSDKManager.h
//  PTGAdSDK_Example
//
//  Created by 苏相荣 on 2020/7/6.
//  Copyright © 2020 yingzhao.fyz. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define PTGAdSKDManagerInstance    [PTGAdSDKManager sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@class PTGSplashAdConfiguration,PTGSlotBiddings,PTGConfigModel,PTGSlotBidding;

@protocol PTGAggregationExtensionProtocol;

typedef void (^SuccessCallBack)(BOOL result);

@interface PTGAdSDKManager : NSObject

@property (nonatomic, copy, readonly) NSString *appKey;
@property (nonatomic, strong, readonly) PTGConfigModel *configModel;
@property (nonatomic, copy, readonly) NSString *ptgApiUrl;


+ (instancetype)sharedInstance;
/**
*  属性 isPenPTG
*  详解：是否开启媒体PTG
*  默认属性Yes
*/
//+ (void)setIsOPenPTG:(BOOL)openPTG;

/**
*  详解：LogEnable - 是否开启日志
*  默认debug下开启日志
*/
+ (void)setLogEnable:(BOOL)LogEnable;

/**
*  构造方法 getSDkVersion
*  详解：获取sdk版本
*
*/
+ (NSString *)getSDkVersion;

/**
 *  构造方法
 *  详解：设置appkey和appsecret
 *       adSize - 广告展示的宽高
 */
+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret success:(SuccessCallBack)success;

/**
*   以下私有方法  非对外
*/
- (PTGSlotBiddings *)consumerSlotId:(NSString *)slotId;

@end

NS_ASSUME_NONNULL_END


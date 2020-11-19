//
//  PTGAdSDKManager.h
//  PTGAdSDK_Example
//
//  Created by 苏相荣 on 2020/7/6.
//  Copyright © 2020 yingzhao.fyz. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//#import <PTGAdSDK/PTGAggregationExtensionProtocol.h>

#define PTGAdSKDManagerInstance    [PTGAdSDKManager sharedInstance]

NS_ASSUME_NONNULL_BEGIN
@class PTGSplashAdConfiguration,PTGSlotBiddings,PTGConfigModel,PTGSlotBidding;
@protocol PTGAggregationExtensionProtocol;

typedef void (^SuccessCallBack)(BOOL result);

@interface PTGAdSDKManager : NSObject

@property (nonatomic, readonly, copy) NSString *appKey;

+ (instancetype)sharedInstance;
/**
*  属性 isPenPTG
*  详解：是否开启媒体PTG
*  默认属性Yes
*/
//+ (void)setIsOPenPTG:(BOOL)openPTG;

/**
*  构造方法 getSDkVersion
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
 *  详解：placementId - 广告位 ID
 *       adSize - 广告展示的宽高
 */

+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret success:(SuccessCallBack)success;



/**
*   以下私有方法  非对外
*/
+ (void)testUseAd:(NSInteger)index;
- (void)loadAd;//TODO 后续加上数字返回几个定义 + 接口支持
- (NSMutableDictionary *)_requestPtgApiUrlData:(NSString *)consumerSlotId;
- (NSString *)_getPtgApiUrl;
- (UIImage *)imagebundlePath:(NSString *)name;
- (PTGSlotBiddings *)consumerSlotId:(NSString *)slotId;
- (PTGConfigModel *)getConfigModel;
@end

NS_ASSUME_NONNULL_END


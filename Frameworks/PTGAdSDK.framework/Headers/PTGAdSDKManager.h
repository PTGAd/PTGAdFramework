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

@class PTGConfigModel, PTGSlotBiddings;

typedef void (^SuccessCallBack)(BOOL result);

@interface PTGAdSDKManager : NSObject

@property (nonatomic, readonly, copy) NSString *appKey;
@property (nonatomic, readonly, copy) NSString *appSecret;
@property (nonatomic, readonly, strong) PTGConfigModel *configModel;
@property (nonatomic, readonly, copy) NSString *ptgApiUrl;

+ (instancetype)sharedInstance;

/**
*  构造方法 setLogEnable
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
 *  详解：设置appkey和secret
 */
+ (void)setAppKey:(NSString *)appKey appSecret:(NSString *)appSecret success:(SuccessCallBack)success;

///**
//*   以下私有方法  非对外
//*/
//- (void)loadAd;//TODO 后续加上数字返回几个定义 + 接口支持
- (PTGSlotBiddings *)consumerSlotId:(NSString *)slotId;

@end

NS_ASSUME_NONNULL_END

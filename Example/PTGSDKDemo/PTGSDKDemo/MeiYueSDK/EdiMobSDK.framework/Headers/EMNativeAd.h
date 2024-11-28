//
//  MYNativeAd.h
//  MYAdsSDK
//
//  Created by Eric on 2021/5/4.
//  Copyright © 2021 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EdiMobSDK/EMAdsProtocol.h>

@class EMNativeAdDataObject;

@protocol EMNativeAdDelegate <NSObject>
/**
 * 拉取原生广告成功
 */
- (void)EM_nativeAdSuccessToDatas:(NSArray<__kindof EMNativeAdDataObject *> *)objects;

/**
 * 拉取原生广告失败
 */
- (void)EM_nativeAdFailToLoad:(NSError *)error;

@end

@interface EMNativeAd : NSObject<EMAdsProtocol>

@property (nonatomic, weak) id<EMNativeAdDelegate> delegate;


/**
 *  构造方法
 *  详解：slotId    - 广告位 ID
 */
- (instancetype)initWithSlotId:(NSString *)slotId;

/**
 * 拉取广告
 * @param count 广告条数
 *  详解：[必选]发起拉取广告请求,在获得广告数据后回调delegate
 *  最多十条
 */
- (void)EM_loadAd:(int)count;

@end



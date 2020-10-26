//
//  PTGNativeExpressAd.h
//  PTGAFNetworking
//
//  Created by admin on 2020/8/11.
//  Copyright © 2020 PTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTGAdvertising.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^DataCorrection)(BOOL result,NSArray * views);

@protocol PTGNativeExpressAdDelegete <NSObject>

@optional
/**
 * 原生模板广告点击回调
 */
- (void)nativeExpressAdViewClicked:(UIView *)nativeExpressAdView;

/**
 * 原生模板广告被关闭
 */
- (void)nativeExpressAdViewClosed:(UIView *)nativeExpressAdView;
/**
 * 拉取原生模板广告成功
 */
- (void)nativeExpressAdSuccessToLoad:(NSObject *)nativeExpressAd views:(NSArray<__kindof UIView *> *)views;

/**
 * 拉取原生模板广告失败
 */
- (void)nativeExpressAdFailToLoad:(NSObject *)nativeExpressAd error:(NSError *)error;

/**
 * 原生模板广告渲染成功, 此时的 nativeExpressAdView.size.height 根据 size.width 完成了动态更新。
 */
- (void)nativeExpressAdViewRenderSuccess:(UIView *)nativeExpressAdView;

/**
 * 原生模板广告关闭PTGNativeExpressAd-->nativeExpress
 * 用处不大 可忽略
 */
- (void)nativeExpressAdViewNationClosed:(NSObject *)nativeExpress;


@end

@protocol PTGAggregationExtensionProtocol;

@interface PTGNativeExpressAd : PTGAdvertising



- (instancetype)initWithPlacementId:(NSString *)placementId adSize:(CGSize)size;
/**
 *  构造方法
 *  详解：placementId - 广告位 ID
 *  adSize - 广告展示的宽高
 */
//拆分
@property (nonatomic, weak) id<PTGNativeExpressAdDelegete> delegate;


@property (nonatomic, strong) id<PTGAggregationExtensionProtocol> adManager;


/**
*  渲染方法
*  详解：obj - view
*  controller 
*/
- (void)render:(id)obj controller:(UIViewController *)controller;


/**
*  DataCorrection (BOOL result,NSArray *  views);
*  数据成功回调 result  true 是成功  false 失败
*  views
 */
- (void)dataCorrectionHandler:(DataCorrection)correction;

/**
*
*  数据加载的时候使用
*
*/
- (void)loadAdData;



@end

NS_ASSUME_NONNULL_END

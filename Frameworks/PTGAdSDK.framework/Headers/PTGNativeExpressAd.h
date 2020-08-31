//
//  PTGNativeExpressAd.h
//  PTGAFNetworking
//
//  Created by admin on 2020/8/11.
//  Copyright © 2020 PTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^DataCorrection)(BOOL result,NSArray * _Nonnull views);

@protocol PTGNativeExpressAdDelegete <NSObject>

@optional
/**
 * 原生模板广告点击回调
 */
- (void)nativeExpressAdViewClicked:(UIView *_Nonnull)nativeExpressAdView;

/**
 * 原生模板广告被关闭
 */
- (void)nativeExpressAdViewClosed:(UIView *_Nonnull)nativeExpressAdView;
/**
 * 拉取原生模板广告成功
 */
- (void)nativeExpressAdSuccessToLoad:(NSObject *_Nullable)nativeExpressAd views:(NSArray<__kindof UIView *> *_Nonnull)views;

/**
 * 拉取原生模板广告失败
 */
- (void)nativeExpressAdFailToLoad:(NSObject *_Nonnull)nativeExpressAd error:(NSError *_Nullable)error;

/**
 * 原生模板广告渲染成功, 此时的 nativeExpressAdView.size.height 根据 size.width 完成了动态更新。
 */
- (void)nativeExpressAdViewRenderSuccess:(UIView *_Nonnull)nativeExpressAdView;




@end

NS_ASSUME_NONNULL_BEGIN
@protocol PTGAggregationExtensionProtocol;

@interface PTGNativeExpressAd : NSObject



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
*  DataCorrection (BOOL result,NSArray * _Nonnull views);
*  数据成功回调 result  true 是成功  false 失败
 
*  views 成功以后的数据源
*/

@property(nonatomic, copy)DataCorrection sucess;

/**
*  渲染方法
*  详解：obj - view
*  controller 
*/
- (void)render:(id)obj controller:(UIViewController *)controller;

/**
*  暂时作废
*/

//- (void)loadAd:(NSInteger)count;



@end

NS_ASSUME_NONNULL_END

//
//  IFLYNativeAd.h
//  AD_Demo
//
//  Created by chengping on 15/12/18.
//  Copyright © 2015年 faf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class IFLYAdData;
@class IFLYAdError;
@class IFLYNativeAd;

@protocol IFLYNativeAdDelegate <NSObject>

/**
 *  原生广告加载广告数据成功回调
 *
 */
- (void)onNativeAdReceived:(IFLYAdData *)adData;

/**
 *  原生广告错误回调
 *
 */
- (void)onNativeAdFailed:(IFLYAdError *)error;

@end


@interface IFLYNativeAd : NSObject

/**
 *  委托对象
 */
@property (nonatomic, weak) id<IFLYNativeAdDelegate> delegate;

/**
 *  父视图
 *  需设置为显示广告的UIViewController
 */
@property (nonatomic, weak) UIViewController *currentViewController;

/**
 *  构造方法
 *  详解：adUnitId是广告位id
 */
- (instancetype)initWithAdUnitId:(NSString *)adUnitId;

/**
 *  设置广告配置参数
 */
- (void)setParamValue:(NSObject*)value forKey:(NSString *)key;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求,在获得广告数据后回调delegate
 */
- (void)loadAd;

/**
 *  广告数据渲染完毕即将展示时调用方法
 *  详解：[必选]广告数据渲染完毕，即将展示时需调用本方法。
 *      @param view         渲染出的广告结果页面
 */
- (BOOL)attachAd:(UIView *)view;

/**
 *  开屏广告数据渲染完毕即将展示时调用方法
 *  详解：[必选]广告数据渲染完毕，即将展示时需调用本方法。
 *      @param view         渲染出的广告结果页面
 */
- (BOOL)attachWindowAd:(UIView *)view;

/**
 *  广告点击调用方法
 *  详解：当用户点击广告时，开发者需调用本方法，系统会弹出内嵌浏览器、或内置AppStore、
 *      或打开系统Safari，来展现广告目标页面
 *      @param view         渲染出的广告结果页面
 */
- (BOOL)clickAd:(UIView *)view;

/**
 *  广告点击为deeplink时是否禁用deeplink跳转
 *  详解：当用户点击广告时，设置是否禁止进行deeplink跳转，默认NO启用
 *      @param disable         YES禁用deeplink跳转，NO启用
 */
- (void)setDeepLinkDisable:(BOOL)disable;

/**
 * 广告退出落地页的回调
 */
@property (nonatomic, copy) void(^dismissBlock)(void);

/**
 * deeplink跳转离开app回调
 */
@property (nonatomic, copy) void(^didLeaveApp)(void);

/**
 * 广告点击跳转动画开始回调
 */
@property (nonatomic, copy) void(^clickAdAnimateStartBlock)(void);

/**
 * 广告点击跳转动画结束回调
 */
@property (nonatomic, copy) void(^clickAdAnimateCompleteBlock)(void);

/**
 * 广告点击关闭动画开始回调
 */
@property (nonatomic, copy) void(^closeAdAnimateStartBlock)(void);

/**
 * 广告点击关闭动画结束回调
 */
@property (nonatomic, copy) void(^closeAdAnimateCompleteBlock)(void);


@end

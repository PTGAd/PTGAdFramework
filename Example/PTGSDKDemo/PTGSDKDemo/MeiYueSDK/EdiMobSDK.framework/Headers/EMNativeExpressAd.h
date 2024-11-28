//
//  MYNativeExpressAd.h
//  MYAdsSDK
//
//  Created by liudehan on 2018/8/13.
//  Copyright © 2018年 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EdiMobSDK/EMAdsProtocol.h>

@class EMNativeExpressAdView;

@protocol EMNativeExpressAdDelegate <NSObject>
/**
 * 拉取原生模板广告成功
 */
- (void)EM_nativeExpressAdSuccessToViews:(NSArray<__kindof EMNativeExpressAdView *> *)views;

/**
 * 拉取原生模板广告失败
 */
- (void)EM_nativeExpressAdFailToLoad:(NSError *)error;

/**
 * 原生模板广告曝光回调
 */
- (void)EM_nativeExpressAdExposure:(EMNativeExpressAdView *)nativeExpressAdView;

/**
 *  原生模板广告点击回调
 */
- (void)EM_nativeExpressAdClick:(EMNativeExpressAdView *)nativeExpressAdView;

@optional
/**
 * 原生模板广告渲染成功后回调;
 */
- (void)EM_nativeExpressAdViewRenderSuccess:(EMNativeExpressAdView *)nativeExpressAdView;
/**
 * 原生模板广告点击关闭;
 */
- (void)EM_nativeExpressAdViewClosed:(EMNativeExpressAdView *)nativeExpressAdView;

@end


@interface EMNativeExpressAd : NSObject<EMAdsProtocol>

@property (nonatomic, weak) id<EMNativeExpressAdDelegate> delegate;

/*
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *currentController;

/**
 *  构造方法
 *  详解：slotId   - 广告位 ID
 *       adSize - 广告展示的宽高,宽为屏幕宽度 高度最优自适应
 */
- (instancetype)initWithSlotId:(NSString *)slotId adSize:(CGSize)size;

/**
 * 拉取广告
 @param count 广告条数
 *  详解：[必选]发起拉取广告请求,在获得广告数据后回调delegate
 *  最多十条
 */
- (void)EM_loadAd:(int)count;

@end

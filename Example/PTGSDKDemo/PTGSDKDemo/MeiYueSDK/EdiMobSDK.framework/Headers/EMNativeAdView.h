//
//  MYNativeAdView.h
//  MYAdsSDK
//
//  Created by Eric on 2021/5/4.
//  Copyright © 2021 King_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EMMediaView;
@class EMNativeAdDataObject;

@protocol EMNativeAdViewDelegate <NSObject>

/**
 * 原生广告曝光
 */
- (void)EM_nativeAdViewExpose;


/**
 * 原生广告点击
 */
- (void)EM_nativeAdViewDidClick;

@end

@interface EMNativeAdView : UIView

@property (nonatomic, weak) id<EMNativeAdViewDelegate> delegate;

/**
 *  视频广告的媒体View，绑定数据对象后自动生成，可自定义布局
 */
@property (nonatomic, strong, readonly) EMMediaView *mediaView;

/**
 *  LogoView，自动生成，可自定义布局
 */
@property (nonatomic, strong, readonly) UIImageView *logoView;

/**
 *  viewControllerForPresentingModalView
 *  详解：开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *viewController;

/**
 *  自渲染视图点击事件注册方法
 *  @param dataObject 数据对象，必传字段
 *  @param clickableViews 可点击的视图数组，此数组内的广告元素才可以响应广告对应的点击事件
 */
- (void)registerDataObject:(EMNativeAdDataObject *)dataObject
            clickableViews:(NSArray<UIView *> *)clickableViews;

/**
 *  解绑数据对象
 *  如需要解绑数据对象，可使用下面方法
 */
- (void)unregisterDataObject;

/**
 * 视图渲染 「必须实现」
 * 当广告视图展示时调用，不调用会影响广告的曝光统计
 */
- (void)render;

@end

//
//  IFLYBannerAd.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/9/26.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IFLYAdError;
@class IFLYBannerAd;

@protocol IFLYBannerAdDelegate <NSObject>
/**
 *  请求横幅广告成功
 */
- (void)onBannerAdReceived:(IFLYBannerAd *)banner;
/**
 *  请求横幅广告错误
 *
 *  @param errorCode 错误码，详见接入手册
 */
- (void)onBannerAdFailed:(IFLYAdError *)errorCode;
/**
 *  横幅广告关闭回调
 */
- (void)onBannerAdClosed;
/**
 *  横幅广告广告点击回调
 */
- (void)onBannerAdClicked;


@end

@interface IFLYBannerAd : NSObject

/**
 *  横幅广告代理
 */
@property ( nonatomic, weak ) id<IFLYBannerAdDelegate> delegate;

/**
 *  父视图
 *  需设置为显示广告的UIViewController
 */
@property (nonatomic, weak) UIViewController *currentViewController;

/**
 *  是否自动轮播
 */
@property (nonatomic, assign) BOOL isAutoRequest;

/**
 *  设置横幅广告位置
 *
 *  @param origin 横幅广告坐标点
 *
 *  @return 返回横幅广告对象
 */
- (id) initWithOrigin:(CGPoint)origin;

/**
 *  设置广告配置参数
 */
-(void) setParamValue:(NSObject*)value forKey:(NSString *)key;

/**
 *  获取横幅view
 *
 *  @return 返回横幅view
 */
- (UIView *) bannerAdView;

/**
 *  请求横幅广告
 *
 *  @param adUnitId 广告位
 *  @param autoRequest 是否轮播请求广告
 */
- (void) loadAd:(NSString *) adUnitId autoRequest:(BOOL) autoRequest;

/**
 *  请求横幅广告
 *
 *  @param adUnitId 广告位id
 */
- (void) loadAd:(NSString *) adUnitId;

/**
 *  销毁广告
 */
- (void) destroyAd;

@end

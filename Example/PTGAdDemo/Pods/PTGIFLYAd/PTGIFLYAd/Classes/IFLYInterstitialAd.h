//  IFLYInterstitialAd.h
//
//
//  Created by cheng ping on 14/10/20.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IFLYAdError;

@protocol IFLYInterstitialAdDelegate <NSObject>
/**
 *  请求插屏广告成功
 */
- (void)onInterstitialAdReceived;
/**
 *  请求插屏广告错误
 *
 *  @param errorCode 错误码，详见接入手册
 */
- (void)onInterstitialAdFailed:(IFLYAdError *)errorCode;
/**
 *  插屏广告关闭回调
 */
- (void)onInterstitialAdClosed;
/**
 *  广告被点击
 */
- (void)onInterstitialAdClicked;

@end

@interface IFLYInterstitialAd : NSObject

/**
 *  插屏广告代理
 */
@property (nonatomic, weak) id<IFLYInterstitialAdDelegate> delegate;

/**
 *  父视图
 *  需设置为显示广告的UIViewController
 */
@property (nonatomic, weak) UIViewController *currentViewController;

/**
 *  获取插屏广告对象
 *
 *  @return 返回IFLYInterstitialAd对象
 */
+ (instancetype)sharedInstance;

/**
 *  设置广告配置参数
 */
- (void)setParamValue:(NSObject*)value forKey:(NSString *)key;

/**
 *  请求插屏广告
 *
 *  @param adUnitId 广告位id
 */
- (void)loadAd:(NSString *) adUnitId;

/**
 *  展现插屏广告
 */
- (void)showAd;

@end

//
//  MYInterstitialAd.h
//  MYAdsSDK

//  Created by liudehan on 2017/8/28.
//  Copyright © 2017年 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EdiMobSDK/EMAdsProtocol.h>

@protocol EMInterstitialAdDelegate <NSObject>

@optional

/**
 *  广告预加载成功回调
 *  详解:当接收服务器返回的广告数据成功后调用该函数
 *  在此方法中调用FAL_presentFromRootViewController：需放在主线程中
 */
- (void)EM_interstitialSuccessToLoadAd;

/**
 *  广告预加载失败回调
 *  详解:当接收服务器返回的广告数据失败后调用该函数
 */
- (void)EM_interstitialFailToLoadAd:(NSError *)error;

/**
 *  插屏广告展示结束回调
 *  详解: 插屏广告展示结束回调该函数
 */
- (void)EM_interstitialClose;

/**
 *  插屏广告视图展示成功回调
 *  详解: 插屏广告展示成功回调该函数
 */
- (void)EM_interstitialExposure;

/**
 *  插屏广告点击回调
 */
- (void)EM_interstitialClicked;


@end

@interface EMInterstitialAd : NSObject<EMAdsProtocol>

/**
 *  委托对象
 */
@property (nonatomic, weak) id<EMInterstitialAdDelegate> delegate;


/*
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 *  当需要在Tabbar页面弹出时，根视图须设置为Tabbar，否则会影响广告后续点击
 */
@property (nonatomic, weak) UIViewController *viewController;

/**
 *  构造方法
 */
-(instancetype)initWithSlotId:(NSString *)slotId;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求
 */
-(void)EM_loadAd;

/**
 *  广告展示方法
 *  详解：[必选]发起展示广告请求, 必须传入用于显示插播广告的UIViewController
 */
-(void)EM_presentFromRootViewController:(UIViewController *)rootViewController;

/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;
@end


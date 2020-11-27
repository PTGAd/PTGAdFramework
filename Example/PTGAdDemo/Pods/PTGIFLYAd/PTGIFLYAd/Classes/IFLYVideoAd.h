//
//  IFLYVideoAd.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/12/19.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 * 视频广告类型
 */
typedef NS_ENUM(NSInteger, IFLYVideoAdType) {
    // 激励视频
    IFLYVideoAdTypeReward,
    // 开屏视频
    IFLYVideoAdTypeSplash,
    // 信息流视频
    IFLYVideoAdTypeNative
};

@class IFLYAdData;
@class IFLYAdError;
@class IFLYVideoAd;

@protocol IFLYVideoAdDelegate <NSObject>

/**
 * 视频广告加载成功回调
 * @param adData IFLYAdData对象
 */
- (void)onVideoAdReceived:(IFLYAdData *)adData;

/**
 * 视频广告失败回调
 */
- (void)onVideoAdFailed:(IFLYAdError *)error;

@optional

/**
 * 视频广告加载成功回调
 * @param videoAdData IFlyAdData对象
 * @param videoSize   视频大小
 */
- (void)onPreloadSuccess:(IFLYAdData *)videoAdData withSize:(CGSize)videoSize;

/**
 * 视频广告预加载失败回调
 */
- (void)onPreloadFailed:(IFLYAdError *)error;


/**
 *  视频开始播放
 */
- (void)adStartPlay;
/**
 *  视频播放出错
 */
- (void)adPlayError;
/**
 *  视频播放结束
 */
- (void)adPlayCompleted;
/**
 *  视频重新播放
 */
- (void)adReplay;

/**
 *  广告被点击
 */
- (void)onVideoAdClicked;

@end


@interface IFLYVideoAd : NSObject

/**
 *  委托对象
 */
@property (nonatomic, weak) id<IFLYVideoAdDelegate> delegate;
/**
 *  父视图
 *  需设置为显示广告的UIViewController
 */
@property (nonatomic, weak) UIViewController *currentViewController ;

/**
 *  父view
 *  需设置为显示广告的UIView
 */
@property (nonatomic, weak) UIView *fatherView;
/** 静音（默认为NO）*/
@property (nonatomic, assign) BOOL  mute;
/** 自动播放（默认为NO）*/
@property (nonatomic, assign) BOOL  autoPlay;
/** 视频广告类型 */
@property (nonatomic, assign) IFLYVideoAdType videoType;
/** cell播放视频，以下属性必须设置值 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** cell所在的indexPath */
@property (nonatomic, strong) NSIndexPath  *indexPath;
/**
 * cell上播放必须指定
 * 播放器View的父视图tag（根据tag值在cell里查找playerView加到哪里)
 */
@property (nonatomic, assign) NSInteger fatherViewTag;

/**
 *  构造方法
 *  详解：adUnitId是广告位id
 */
- (instancetype)initWithAdUnitId:(NSString *)adUnitId;

/**
 *  设置广告请求配置参数
 */
- (void)setParamValue:(NSObject*)value forKey:(NSString *)key;

/**
 *  设置广告请求配置参数,点击视频广告是否直接跳转
 */
- (void)setDerectJump:(BOOL)value;

/**
 *  视频广告预加载
 *  详解：预发起拉取广告请求，在获得广告后回调delegate
 */
- (void)preloadAd;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求,在获得广告数据后回调delegate
 */
- (void)loadAd;
/**
 *  展示视频视图
 */
- (void)showAd;
/**
 *  广告曝光
 */
- (BOOL)attachAd;
/**
 *  广告曝光,当view附着在window上
 */
- (BOOL)attachWindowAd:(UIView *)view;
/**
 *  广告点击
 */
- (BOOL)clickAd;

/**
 *  开始播放
 */
- (void)startPlay;
/**
 *  暂停播放
 */
- (void)pausePlay;
/**
 *  结束播放
 */
- (void)stopPlay;

/**
 * 广告退出落地页的回调
 */
@property (nonatomic, copy) void(^dismissBlock)(void);
/**
 * deeplink跳转离开app回调
 */
@property (nonatomic, copy) void(^didLeaveApp)(void);

@end

//
//  PTGNativeExpressAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGNativeExpressAd : NSObject

/// 是否渲染完毕
@property(nonatomic, assign, readonly)BOOL isReady;

/// 是否是视频模板广告
@property(nonatomic, assign, readonly)BOOL isVideoAd;

/// 详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
@property(nonatomic, weak)UIViewController *controller;

/// 设置广告的origin
@property(nonatomic,assign)CGPoint origin;


/// [必选]原生模板广告渲染
- (void)render;

/// 视频模板广告时长，单位 ms 
- (CGFloat)videoDuration;

/// 视频模板广告已播放时长，单位 ms
- (CGFloat)videoPlayTime;

/// 显示广告到视图上 view为需要将广告显示到的视图
- (void)displayAdToView:(UIView *)view;

/// 广告的高度 需要在广告渲染成功后调用才能获取到正确的高度
- (CGFloat)adHeight;

- (void)darwUnregisterView;

@end

NS_ASSUME_NONNULL_END

//
//  PTGNativeExpressAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/18.
//

#import <UIKit/UIKit.h>
#import "PTGSourceAdType.h"

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

/// 价格 单位分
@property(nonatomic,assign)NSInteger price;

/// 消耗方类型
@property(nonatomic,assign)PTGAdSourceType sourceType;

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


/// ===== 适配自渲染广告 =======

/** 设置可以点击和关闭的图层 */
- (void)setContainer:(UIView *)containerView clickableView:(UIView *)clickableView;

/// 媒体视图  用于视屏广告，使用此属性更改 视图的frame
@property(nonatomic,strong,readonly)UIView *mediaView;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 副标题
@property (nonatomic, copy) NSString *body;

/// icon图片下载链接
@property (nonatomic, copy) NSString *iconUrl;

/// 点击按钮文案
@property (nonatomic, copy) NSString *callToAction;

/// App Store评分
@property (nonatomic, assign) double rating;

/// 素材地址
@property (nonatomic, strong) NSArray <NSString *> *imageUrls;

@property (nonatomic, assign) BOOL rendering;

@end

NS_ASSUME_NONNULL_END

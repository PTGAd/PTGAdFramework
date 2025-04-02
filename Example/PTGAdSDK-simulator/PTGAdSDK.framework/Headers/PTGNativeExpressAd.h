//
//  PTGNativeExpressAd.h
//  PTGAdSDK
//
//  Created by admin on 2021/1/18.
//

#import <UIKit/UIKit.h>
#import "PTGSourceAdType.h"
@class PTGNativeExpressAd;

NS_ASSUME_NONNULL_BEGIN

@interface PTGMediaInfo: NSObject
/// 素材宽
@property (nonatomic, assign, readonly) int width;
/// 素材高
@property (nonatomic, assign, readonly) int height;
/// 图片素材地址
@property (nonatomic, copy, readonly) NSString* url;
/// 视频地址
@property (nonatomic, copy, readonly) NSString *videoUrl;
/// 封面图地址
@property (nonatomic, copy, readonly) NSString *coverImageUrl;
/// 视频时长(s)
@property (nonatomic, assign, readonly) float duration;

@end

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
/// 开屏自渲染使用这个方法 开屏一定要使用这个方法
/// 确保 setContainer 及 clickableView 不为空 为空时广告事件异常
- (void)setSplashContainer:(UIView *)containerView clickableViews:(NSArray<UIView *> *)clickableViews;

/** 其他广告位置设置可以点击和关闭的图层 */
/// 确保 setContainer 及 clickableView 不为空 为空时广告事件异常
- (void)setContainer:(UIView *)containerView clickableViews:(NSArray<UIView *> *)clickableViews;
/// 视频广告调用
- (UIView *)getVideoAdView;
/// 视频广告是否静音
@property (nonatomic, assign) BOOL muted;
/// 标题
@property (nonatomic, copy,readonly) NSString *title;
/// 副标题
@property (nonatomic, copy,readonly) NSString *body;

/// icon图片下载链接
@property (nonatomic, copy,readonly) NSString *iconUrl;

/// 点击按钮文案
@property (nonatomic, copy,readonly) NSString *callToAction;

/// App Store评分
@property (nonatomic, assign,readonly) double rating;

/// 素材地址
@property (nonatomic, strong) NSArray <PTGMediaInfo *> *imageUrls;

@property (nonatomic, assign,readonly) BOOL rendering;
/// 视频类素材描述
@property(nonatomic,strong,readonly)PTGMediaInfo *videoAdInfo;

/// 是否响应摇一摇 开屏自渲染使用 用于媒体实现摇一摇UI
@property(nonatomic,assign,readonly)BOOL isShakeAd;
@end

NS_ASSUME_NONNULL_END

//
//  PTGNativeAdObject.h
//  PTGAdSDK
//
//  Created by admin on 2024/1/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGNativeAdData.h>
#import <PTGAdSDK/PTGNativeAdRelatedView.h>


NS_ASSUME_NONNULL_BEGIN

@interface PTGNativeAdObject : NSObject

/// 广告数据
@property (nonatomic, strong, readonly) PTGNativeAdData *adData;
/// 视频relatedView
@property (nonatomic, strong, readonly)PTGNativeAdRelatedView *relatedView;


/// 开屏自渲染注册容器和可点击视图
/// @param containerView 容器视图
/// @param clickableViews 可点击视图数组
- (void)setSplashContainer:(UIView *)containerView clickableViews:(NSArray<UIView *> *)clickableViews;

/// 其他广告位置注册容器和可点击视图
/// @param containerView 容器视图
/// @param clickableViews 可点击视图数组
- (void)setContainer:(UIView *)containerView clickableViews:(NSArray<UIView *> *)clickableViews;


@end

NS_ASSUME_NONNULL_END

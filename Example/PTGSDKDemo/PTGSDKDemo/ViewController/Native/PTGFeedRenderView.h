//
//  PTGFeedRenderCell.h
//  PTGSDKDemo
//
//  Created by 陶永久 on 2022/11/7.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>
NS_ASSUME_NONNULL_BEGIN

@class PTGFeedRenderView;

/// 由媒体实现自渲染广告的 点击关闭 
@protocol PTGFeedRenderViewDelegate <NSObject>

- (void)renderAdView:(PTGFeedRenderView *)renderView clickClose:(PTGNativeExpressAd *)ad;

@end

@interface PTGFeedRenderView : UIView

- (void)renderAd:(PTGNativeExpressAd *)ad;

@property(nonatomic,weak) id<PTGFeedRenderViewDelegate> delegate;


- (void)playVideo;
- (void)pauseVideo;

@end

NS_ASSUME_NONNULL_END

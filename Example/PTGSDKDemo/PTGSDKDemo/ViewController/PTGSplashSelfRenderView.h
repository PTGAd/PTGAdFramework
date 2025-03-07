//
//  PTGSplashSelfRenderView.h
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/3/5.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGNativeExpressAd.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PTGSplashSelfRenderViewDelegate <NSObject>

- (void)nativeAdViewClosed:(PTGNativeExpressAd *)nativeAd;

@end

@interface PTGSplashSelfRenderView : UIView

- (void)updateUI:(PTGNativeExpressAd *)nativeAd;

@property(nonatomic,weak)id<PTGSplashSelfRenderViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

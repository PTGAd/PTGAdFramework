//
//  PTGBannerView.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PTGExpressBannerViewDelegate <NSObject>

@optional
/**
 This method is called when bannerAdView ad slot loaded successfully.
 @param bannerAdView : view for bannerAdView
 */
- (void)nativeExpressBannerAdViewDidLoad:(UIView *)bannerAdView;

/**
 This method is called when bannerAdView ad slot failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressBannerAdView:(UIView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed.
 */
- (void)nativeExpressBannerAdViewRenderSuccess:(UIView *)bannerAdView;


/**
 This method is called when bannerAdView is clicked.
 */
- (void)nativeExpressBannerAdViewDidClick:(UIView *)bannerAdView;

/**
 This method is called when  closed.
 */
- (void)nativeExpressBannerAdViewDidClose:(UIView *)bannerAdView;

@end
@interface PTGBannerView : UIView
@property (nonatomic, weak, nullable) id<PTGExpressBannerViewDelegate> delegate;

/**
 *  构造方法
 *  详解：frame - banner 展示的位置和大小
 *       placementId - 广告位 ID
 *       viewController - 视图控制器
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placementId:(NSString *)placementId
               viewController:(UIViewController *)viewController;


/**
 *  拉取并展示广告
 */
- (void)loadAdData;

/**
*  私有
*/
- (void)adverDidLoadRefreshfailure;

@end





NS_ASSUME_NONNULL_END

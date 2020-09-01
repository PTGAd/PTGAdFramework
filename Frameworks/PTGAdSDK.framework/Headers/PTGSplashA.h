//
//  PTGSplashA.h
//  PTGAFNetworking
//
//  Created by admin on 2020/8/13.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN


@protocol PTGSplashAdDelegate <NSObject>

@optional
/**
 *  开屏广告成功展示
 */
- (void)splashAdSuccessPresentScreen:(NSObject *)splashAd;

/**
 *  开屏广告点击回调
 */
- (void)splashAdClicked:(NSObject *)splashAd;


/**
 *  开屏广告关闭回调
 */
- (void)splashAdClosed:(NSObject *)splashAd;


/**
 *  开屏广告展示失败
 */
- (void)splashAdFailToPresent:(NSObject *)splashAd withError:(NSError *)error;


/**
 *  此方法在splash详情广告即将关闭时调用
 */
- (void)splashAdDidCloseOtherController:(NSObject *)splashAd;




@end
@protocol PTGAggregationExtensionProtocol;


@interface PTGSplashA : NSObject


@property (nonatomic, strong) id<PTGAggregationExtensionProtocol > adManager;


/**
 *  委托对象
 */
@property (nonatomic, weak) id<PTGSplashAdDelegate> delegate;

@property (nonatomic, strong,readonly) UIView *bottomView;


@property (nonatomic, strong) UIWindow *keyWindow;

/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;





- (instancetype)initWithPlacementId:(NSString *)placementId bottomView :(UIView *)bottomView;

/**
 *  发起拉取广告请求，只拉取不展示
 *  详解：广告素材及广告图片拉取成功后会回调splashAdDidLoad方法，当拉取失败时会回调splashAdFailToPresent方法
 */
- (void)loadAd;



/**
*   非对外
*/
- (void)splashAdDidLoadRefreshfailure;

@end

NS_ASSUME_NONNULL_END

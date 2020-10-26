//
//  PTGInterstitialAd.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTGAdvertising.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PTGInterstitialAdDelegate;
@interface PTGInterstitialAd : PTGAdvertising

@property (nonatomic, weak, nullable) id<PTGInterstitialAdDelegate> delegate;

/**
 Initializes interstitial ad.
 @param placementId : The unique identifier of interstitial ad.
 @param expectSize : custom size, default 600px * 400px
 @return PTGInterstitialAd
 */
- (instancetype)initWithPlacementId:(NSString *)placementId size:(PTGProposalSize)expectSize;


/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 */
- (void)showRootViewController:(UIViewController *)rootViewController;


/**
 Load interstitial ad datas.
 */
- (void)loadAdData;

@end
@protocol PTGInterstitialAdDelegate <NSObject>
@optional
/**
 This method is called when interstitial ad material loaded successfully.
 加载成功以后记得调取showRootViewController
 */
- (void)interstitialAdDidLoad:(NSObject *)interstitialAd;

/**
 This method is called when interstitial ad material failed to load.
 @param error : the reason of error
 */
- (void)interstitialAd:(NSObject *)interstitialAd didFailWithError:(NSError * _Nullable)error;
/**
 This method is called when interstitial ad is clicked.
 */
- (void)interstitialAdDidClick:(NSObject *)interstitialAd;
/**
 This method is called when interstitial ad slot will be showing.
 */
- (void)interstitialAdWillVisible:(NSObject  *)interstitialAd;

/**
 This method is called when interstitial ad is closed.
 */
- (void)interstitialAdDidClose:(NSObject *)interstitialAd;


@end
NS_ASSUME_NONNULL_END

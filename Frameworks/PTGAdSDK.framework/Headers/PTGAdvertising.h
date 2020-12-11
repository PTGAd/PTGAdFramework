//
//  PTGAdvertising.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTGCommentMacros.h"

NS_ASSUME_NONNULL_BEGIN

@class PTGBannerView;

@interface PTGAdvertising : NSObject
//
@property (nonatomic, copy) NSString *placementId;
@property (nonatomic, assign) CGSize adSize;
@property (nonatomic, assign) NSInteger type;//暂时 0 是 开屏 1 信息流 2 插屏 3 横幅 4.激励视频

@property (nonatomic, assign) PTGProposalSize expectSize;

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) PTGBannerView *bannerView;

- (void)concurrent:(NSString *)slotId size:(CGSize)adSize;

- (void)adverDidLoadRefreshfailure;
- (void)addMessageToSendQueue;
- (void)clearAdvertising:(id)manger;
/**
 Display interstitial ad.
 @param rootViewController : root view controller for displaying ad.
 */
- (void)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END

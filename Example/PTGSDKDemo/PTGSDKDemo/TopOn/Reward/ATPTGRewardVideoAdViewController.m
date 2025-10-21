//
//  ATPTGInterstitialAdViewController 2.h
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/6/13.
//


//
//  ATPTGInterstitialAdViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/2/26.
//

#import "ATPTGRewardVideoAdViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>

@interface ATPTGRewardVideoAdViewController ()<ATRewardedVideoDelegate,ATAdLoadingDelegate>

@end

@implementation ATPTGRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

}

- (void)setupUI {
    
    self.title = @"Custom Reward";
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 100)/2, 100, 100, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"loadAd" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)loadAd {
    NSValue *size = [NSValue valueWithCGSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200)];
    NSMutableDictionary *extra = @{
        kATExtraInfoAdSizeKey: size,
        kATExtraInfoRootViewControllerKey: self,

    }.mutableCopy; 
    
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b684b971eed5c9" extra:extra delegate:self];
}

-(void)showAd:(NSString *)placementID {
    if (![[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:placementID]) {
        return;
    }
    [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:placementID inViewController:self delegate:self];
}

/// Callback when the successful loading of the ad
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    [self showAd:placementID];
}

/// Callback of ad loading failure
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error {
    
}

- (void)didRevenueForPlacementID:(NSString *)placementID
                           extra:(NSDictionary *)extra {
    
}


/// Ad start load
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {
    NSLog(@"激励视频开始加载");
}
/// Ad load success
- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    NSLog(@"激励视频加载成功");
}
/// Ad load fail
- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID
                                       extra:(NSDictionary*)extra
                                       error:(NSError*)error {
    NSLog(@"激励视频加载失败error = %@",error);
}

/// Ad start bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {
    NSLog(@"激励视频开始竞价");
}

/// Ad bidding success
- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    NSLog(@"激励视频竞价成功");
}

/// Ad bidding fail
- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID
                                        extra:(NSDictionary*)extra
                                        error:(NSError*)error {
    NSLog(@"激励视频竞价失败 error = %@",error);
}

#pragma mark - ATRewardedVideoDelegate -
/// Rewarded video ad play starts
- (void)rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID
                                             extra:(NSDictionary *)extra {
    
}

/// Rewarded video ad play ends
- (void)rewardedVideoDidEndPlayingForPlacementID:(NSString *)placementID
                                           extra:(NSDictionary *)extra {
    NSLog(@"激励视频播放完成");
}

/// Rewarded video ad clicks
- (void)rewardedVideoDidClickForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra {
    NSLog(@"激励视频点击");
}

/// Rewarded video ad closed
- (void)rewardedVideoDidCloseForPlacementID:(NSString *)placementID
                                   rewarded:(BOOL)rewarded
                                      extra:(NSDictionary *)extra {
    NSLog(@"激励视频关闭 rewarded = %d",rewarded);
}

/// Rewarded video ad reward distribution
- (void)rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID
                                             extra:(NSDictionary *)extra {
    NSLog(@"激励视频奖励成功");
}


/// Rewarded video ad play failed
- (void)rewardedVideoDidFailToPlayForPlacementID:(NSString *)placementID
                                           error:(NSError *)error
                                           extra:(NSDictionary *)extra {
    NSLog(@"激励视频播放失败");
}

/// Whether the click jump of rewarded video ad is in the form of Deeplink
/// note: only suport TopOn Adx ad
- (void)rewardedVideoDidDeepLinkOrJumpForPlacementID:(NSString *)placementID
                                               extra:(NSDictionary *)extra
                                              result:(BOOL)success {
    
}
#pragma mark - rewarded video again

/// Rewarded video ad rewatch ad playback starts
- (void)rewardedVideoAgainDidStartPlayingForPlacementID:(NSString *)placementID
                                                  extra:(NSDictionary *)extra {
    
}

/// Rewarded video ad rewatch ad playback end
- (void)rewardedVideoAgainDidEndPlayingForPlacementID:(NSString *)placementID
                                                extra:(NSDictionary *)extra {
    
}

/// Rewarded video ad rewatch ad playback fail
- (void)rewardedVideoAgainDidFailToPlayForPlacementID:(NSString *)placementID
                                                error:(NSError *)error
                                                extra:(NSDictionary *)extra {
    
}

/// Rewarded video ad rewatch ad playback clicked
- (void)rewardedVideoAgainDidClickForPlacementID:(NSString *)placementID
                                           extra:(NSDictionary *)extra {
    
}

/// Rewarded video ad rewatch ad rewarded distribution
- (void)rewardedVideoAgainDidRewardSuccessForPlacemenID:(NSString *)placementID
                                                  extra:(NSDictionary *)extra {
    
}

///// Callback when the successful loading of the ad
//- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
//    [self showAd:placementID];
//    NSLog(@"插屏广告加载完成");
//}
//
//
//
///// Callback of ad loading failure
//- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
//                                 error:(NSError*)error {
//    NSLog(@"插屏广告加载失败，error = %@",error);
//    
//}
//
//- (void)didRevenueForPlacementID:(NSString *)placementID
//                           extra:(NSDictionary *)extra {
//    
//}
//
//
///// Ad start load
//- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID
//                                         extra:(NSDictionary*)extra {
//    NSLog(@"插屏广告开始加载");
//    
//}
///// Ad load success
//- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID
//                                          extra:(NSDictionary*)extra {
//    NSLog(@"插屏广告加载成功");
//}
///// Ad load fail
//- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID
//                                       extra:(NSDictionary*)extra
//                                       error:(NSError*)error {
//    NSLog(@"插屏广告加载失败 error = %@", error);
//}
//
///// Ad start bidding
//- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID
//                                         extra:(NSDictionary*)extra {
//    NSLog(@"插屏广告开始竞价");
//}
//
///// Ad bidding success
//- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID
//                                          extra:(NSDictionary*)extra {
//    NSLog(@"插屏广告竞价成功");
//}
//
///// Ad bidding fail
//- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID
//                                        extra:(NSDictionary*)extra
//                                        error:(NSError*)error {
//    NSLog(@"插屏广告竞价失败");
//}
//
//
//
///// Interstitial ad displayed successfully
//- (void)interstitialDidShowForPlacementID:(NSString *)placementID
//                                    extra:(NSDictionary *)extra {
//    NSLog(@"插屏广告展示");
//}
//
///// Interstitial ad clicked
//- (void)interstitialDidClickForPlacementID:(NSString *)placementID
//                                     extra:(NSDictionary *)extra {
//    NSLog(@"插屏广告点击");
//}
//
///// Interstitial ad closed
//- (void)interstitialDidCloseForPlacementID:(NSString *)placementID
//                                     extra:(NSDictionary *)extra {
//    NSLog(@"插屏广告关闭");
//}
//
- (void)dealloc {
    NSLog(@"释放了，%s",__FUNCTION__);
}
@end

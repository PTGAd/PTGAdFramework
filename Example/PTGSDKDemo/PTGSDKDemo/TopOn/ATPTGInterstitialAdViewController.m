//
//  ATPTGInterstitialAdViewController.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/2/26.
//

#import "ATPTGInterstitialAdViewController.h"
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>

@interface ATPTGInterstitialAdViewController ()<ATInterstitialDelegate>

@end

@implementation ATPTGInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

}

- (void)setupUI {
    
    self.title = @"Custom Splash";
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

    }.mutableCopy;  ///b67b7e8d47ce7f。 //
    
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b67bfccd4c2323" extra:extra delegate:self];
}

-(void)showAd:(NSString *)placementID {
    if (![[ATAdManager sharedManager] interstitialReadyForPlacementID:placementID]) {
        return;
    }
    [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
//    [[ATAdManager sharedManager] showSplashWithPlacementID:PlacementID scene:@"" window:mainWindow extra:nil delegate:self];
}

#pragma mark - ATInterstitialDelegate -

/// Callback when the successful loading of the ad
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    [self showAd:placementID];
    NSLog(@"插屏广告加载完成");
}



/// Callback of ad loading failure
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error {
    NSLog(@"插屏广告加载失败，error = %@",error);
    
}

- (void)didRevenueForPlacementID:(NSString *)placementID
                           extra:(NSDictionary *)extra {
    
}


/// Ad start load
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {
    NSLog(@"插屏广告开始加载");
    
}
/// Ad load success
- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    NSLog(@"插屏广告加载成功");
}
/// Ad load fail
- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID
                                       extra:(NSDictionary*)extra
                                       error:(NSError*)error {
    NSLog(@"插屏广告加载失败 error = %@", error);
}

/// Ad start bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {
    NSLog(@"插屏广告开始竞价");
}

/// Ad bidding success
- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    NSLog(@"插屏广告竞价成功");
}

/// Ad bidding fail
- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID
                                        extra:(NSDictionary*)extra
                                        error:(NSError*)error {
    NSLog(@"插屏广告竞价失败");
}



/// Interstitial ad displayed successfully
- (void)interstitialDidShowForPlacementID:(NSString *)placementID
                                    extra:(NSDictionary *)extra {
    NSLog(@"插屏广告展示");
}

/// Interstitial ad clicked
- (void)interstitialDidClickForPlacementID:(NSString *)placementID
                                     extra:(NSDictionary *)extra {
    NSLog(@"插屏广告点击");
}

/// Interstitial ad closed
- (void)interstitialDidCloseForPlacementID:(NSString *)placementID
                                     extra:(NSDictionary *)extra {
    NSLog(@"插屏广告关闭");
}

@end

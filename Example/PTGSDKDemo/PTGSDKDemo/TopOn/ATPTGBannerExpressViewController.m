//
//  ATPTGBannerExpressViewController.m
//  PTGSDKDemo
//
//  Created by 陶永久 on 2024/11/12.
//

#import "ATPTGBannerExpressViewController.h"

@interface ATPTGBannerExpressViewController ()<ATBannerDelegate>

@end

@implementation ATPTGBannerExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"Banner";
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 100)/2, UIScreen.mainScreen.bounds.size.height - 100, 100, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"loadAd" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)loadAd{
    NSLog(@"%s", __FUNCTION__);
    NSValue *size = [NSValue valueWithCGSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200)];
    NSDictionary *extra = @{
        kATAdLoadingExtraBannerAdSizeKey: size,
        kATExtraInfoRootViewControllerKey: self
    };
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b6728484581736" extra:extra delegate:self];
}

- (void)showAdWithPlacementID:(NSString *)placementID  {
    BOOL isReady = [[ATAdManager sharedManager] bannerAdReadyForPlacementID:placementID];
    if (!isReady) {
        NSLog(@"topon 横幅广告未准备好");
        return;
    }
    
    [[self.view viewWithTag:1000010] removeFromSuperview];
    ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:@"b6728484581736"];
    bannerView.delegate = self;
    bannerView.presentingViewController = self;
    bannerView.tag = 1000010;
    
    [self.view addSubview:bannerView];
    bannerView.frame = CGRectMake(0, 100, bannerView.frame.size.width,  bannerView.frame.size.height);
}

/// BannerView display results
- (void)bannerView:(ATBannerView *)bannerView didShowAdWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"topon 横幅广告展示, placementID = %@",placementID);
}

/// bannerView click
- (void)bannerView:(ATBannerView *)bannerView didClickWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"topon 横幅广告点击, placementID = %@",placementID);
}

/// bannerView click the close button
- (void)bannerView:(ATBannerView *)bannerView didTapCloseButtonWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    [bannerView removeFromSuperview];
    NSLog(@"topon 横幅广告关闭点击, placementID = %@",placementID);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra error:(NSError *)error { 
    NSLog(@"topon 横幅广告竞价失败, error = %@",error);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra error:(NSError *)error { }

- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error { 
    NSLog(@"topon 横幅广告加载失败 error = %@",error);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 
    NSLog(@"topon 横幅广告竞价成功,  placementID = %@",placementID);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 
    
}

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"topon 横幅广告加载成功");
    [self showAdWithPlacementID:placementID];
}

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 
    
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 
    NSLog(@"topon 横幅广告开始竞价,  placementID = %@",placementID);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 

}


@end

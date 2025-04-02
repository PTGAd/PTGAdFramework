//
//  AppDelegate.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/5.
//

#import "AppDelegate.h"
#import "PTGViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "TopOnAdManager.h"

@interface AppDelegate ()<PTGSplashAdDelegate>

@property(nonatomic,strong)PTGSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[TopOnAdManager sharedManager] initTopOnSDK];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:PTGViewController.new];
    [self.window makeKeyAndVisible];
    
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                {
                    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initAdSDK];
                    });
                }
                    break;
                default:
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initAdSDK];
                    });
                    break;
            }
        }];
    } else {
        
        [self initAdSDK];
    }

    return YES;
}

- (void)initAdSDK {
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    /// 重要 影响广告填充
    /// 配置跟踪id
    /// 重要 影响广告填充
    /// 避免代码中明文出现caid ali_id等字符 审核相关
    [PTGSDKManager setAdIds:@{
        @"idfa":@"idfa",
        @"one_id":@"caid",
        @"one_id_version": @"caidVersion",
        @"last_id": @"lastCaid",
        @"last_id_version": @"lastCaidVersion",
        @"one_ali_id": @"ali_aaid"
    }];
    
    /// appKey  Ptg后台创建的媒体⼴告位ID
    /// appSecret Ptg后台创建的媒体⼴告位密钥
    //  45227 1r8hOksXStGASHrp com.bmlchina.driver
    [PTGSDKManager setAppKey:@"45271" appSecret:@"Y6yyc3zyP3EO9ol8" completion:^(BOOL result,NSError *error) {
        if (result) {
            [self.splashAd loadAd];
        }
    }];
}
#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    [splashAd showAdWithViewController:self.window.rootViewController];
}

/// 开屏加载失败
- (void)ptg_splashAd:(PTGSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告被点击了
- (void)ptg_splashAdDidClick:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告关闭了
- (void)ptg_splashAdDidClose:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

/// 开屏广告详情页面关闭的回调
- (void)ptg_splashAdDidCloseOtherController:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}
 
///  开屏广告将要展示
- (void)ptg_splashAdWillVisible:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

#pragma mark - get -
- (PTGSplashAd *)splashAd {
    if (!_splashAd) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
        logo.accessibilityIdentifier = @"splash_logo";
        logo.frame = CGRectMake(0, 0, 311, 47);
        logo.center = bottomView.center;
        [bottomView addSubview:logo];
        bottomView.backgroundColor = [UIColor whiteColor];
//        bottomView.backgroundColor = [UIColor whiteColor];
        
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900000397"];
        _splashAd.delegate = self;
        _splashAd.rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
        _splashAd.bottomView = bottomView;
    }
    return _splashAd;
}


@end

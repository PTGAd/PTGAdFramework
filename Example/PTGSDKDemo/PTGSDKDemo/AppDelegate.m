//
//  AppDelegate.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/5.
//

#import "AppDelegate.h"
#import "PTGViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>

@interface AppDelegate ()<PTGSplashAdDelegate>

@property(nonatomic,strong)PTGSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:PTGViewController.new];
    [self.window makeKeyAndVisible];
    
    /// appKey  Ptg后台创建的媒体⼴告位ID
    /// appSecret Ptg后台创建的媒体⼴告位密钥
    //  45227 1r8hOksXStGASHrp
    [PTGSDKManager setAppKey:@"45227" appSecret:@"1r8hOksXStGASHrp" completion:^(BOOL result,NSError *error) {
        if (result) {
            [self.splashAd loadAd];
        }
    }];

    return YES;
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
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
        
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900000228"];
        _splashAd.delegate = self;
        _splashAd.rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
        _splashAd.bottomView = bottomView;
    }
    return _splashAd;
}

@end

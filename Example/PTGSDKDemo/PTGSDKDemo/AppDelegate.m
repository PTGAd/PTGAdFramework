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
#import <WebKit/WebKit.h>
#import <OneAdSDK/OneAdSDK.h>
#import "WXApi.h"
#import "WXApiManager.h"
//#import <DoraemonKit/DoraemonManager.h>
//#if DEBUG
//#import "FLEXManager.h"
//#endif


@interface AppDelegate ()<PTGSplashAdDelegate>

@property(nonatomic,strong)PTGSplashAd *splashAd;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[TopOnAdManager sharedManager] initTopOnSDK];
    [WXApi registerApp:@"wxd930ea5d5a258f4f" universalLink:@"https://help.wechat.com/sdksample/"];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:PTGViewController.new];
    [self.window makeKeyAndVisible];
    [PTGSDKManager syncSetAppKey:@"45271" appSecret:@"Y6yyc3zyP3EO9ol8"];
    [self.splashAd loadAd];
    return YES;
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    
}

- (void)ptg_splashAdMaterialDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告素材加载成功");
    [splashAd showAdWithViewController:[UIApplication sharedApplication].windows.firstObject.rootViewController];
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

 
///  开屏广告将要展示
- (void)ptg_splashAdWillVisible:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    return [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
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
        
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900002906"];
        _splashAd.delegate = self;
        _splashAd.bottomView = bottomView;
    }
    return _splashAd;
}
@end

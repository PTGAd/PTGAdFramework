//
//  AppDelegate.m
//  PTGAdFrameworkDeom
//
//  Created by admin on 2020/8/24.
//  Copyright © 2020 admin. All rights reserved.
//

#import "AppDelegate.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import "ViewController.h"
#import "NativeExpressAdViewController.h"



#import <BUAdSDK/BUAdSDKManager.h>
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kDevice_Is_iPhoneX (((int)((KScreenHeight/KScreenWidth)*100) == 216)?YES:NO)

@interface AppDelegate ()<PTGSplashAdDelegate>

@property (nonatomic, strong) PTGSplashA *nativeExpressAd;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImage *splashImage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self addBackgroundImage];
    
    
//    #if DEBUG
//        // Whether to open log. default is none.
//    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
//
//    #endif
//    [BUAdSDKManager setIsPaidApp:NO];
//
    
    
    
    [PTGAdSDKManager setAppKey:@"45227" appSecret:@"1r8hOksXStGASHrp" success:^(BOOL result) {
        if (result) {
            [self showSplash:1];
        }
    }];
    
    
    return YES;
}
- (void)addBackgroundImage{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.splashImage = [UIImage imageNamed:@"SplashNormal"];
    if (kDevice_Is_iPhoneX) {
        self.splashImage  = [UIImage imageNamed:@"SplashX"];
    } else if ([UIScreen mainScreen].bounds.size.height == 480) {
        self.splashImage  = [UIImage imageNamed:@"SplashSmall"];
    }
    self.backImageView = [[UIImageView alloc] initWithFrame:frame];
    _backImageView.image = self.splashImage ;
    [self.window.rootViewController.view addSubview:_backImageView];
}


- (void)showSplash:(NSInteger)index {
  
    self.nativeExpressAd = [[PTGSplashA alloc] initWithPlacementId:@"989" bottomView:[UIView new]];
    self.nativeExpressAd.delegate = self;
    self.nativeExpressAd.hideSkipButton = false;
    [self.nativeExpressAd loadAd];
}

- (void)clearBackView{
    dispatch_async(dispatch_get_main_queue(), ^{
       // UI更新代码
        NSLog(@"删除view");
        [self.backImageView removeFromSuperview];

    });
}
- (void)splashAdSuccessPresentScreen:(NSObject *)splashAd{
    [self clearBackView];
}
- (void)splashAdClosed:(NSObject *)splashAd{
    [self clearBackView];

}
- (void)splashAdFailToPresent:(NSObject *)splashAd withError:(NSError *)error{
    [self clearBackView];

}









@end

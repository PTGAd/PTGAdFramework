//
//  ATTMCustomSplashViewController.m
//  HeadBiddingDemo
//
//  Created by Yc on 2022/10/19.
//

#import "ATPTGSplashViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define PlacementID @"b635261028cd5d"

@interface ATPTGSplashViewController ()<ATSplashDelegate, ATAdLoadingDelegate,ATAdAdapter>

@end

@implementation ATPTGSplashViewController

/*
 ❤️❤️相要使用自定义的adapter加载广告，需要将bundle ID改为：com.TianmuSDK.demo和添加pod 'TianmuSDK'依赖。
 并且CustomSplash文件夹中的各文件的.m文件加入到编译文件中。
 该模块作为示例，可能会受三方平台的API影响，请开发者根据自己想要适配的广告平台进行修改。

 ❤️❤️To use a custom adapter to load ads, change the bundle ID to com.TianmuSDK.demo and add the pod 'TianmuSDK' dependency.
 The.m files of each file in the CustomSplash folder are added to the compile file.
 As an example, this module may be affected by the API of the tripartite platform, and developers are invited to modify it according to the advertising platform they want to adapt to.
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
//    __weak typeof(self) weakSelf = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
//        [weakSelf loadAd];
//        [weakSelf loadInterstitialAd];
//    }];
//    
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
//        [weakSelf showAd];
//        [weakSelf showInterstitialAd:@"b67bfccd4c2323"];
//    }];
    
}

-(void)setupUI{
    
    self.title = @"Custom Splash";
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - 100)/2, 100, 100, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"loadAd" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:18];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.numberOfLines = 0;
    tipLabel.text = @"Please check the ATTMCustomSplashViewController.m for hints";
    [self.view addSubview:tipLabel];
    tipLabel.frame = CGRectMake(50, 200, (kSCREEN_WIDTH-100), 200);
    
}

-(void)loadAd{
    NSLog(@"%s", __FUNCTION__);
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 120)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [bottomView addSubview:logo];
    
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b672847ed0c1a2" extra:@{} delegate:self containerView:bottomView];
}

-(void)showAd{
    if (![[ATAdManager sharedManager] splashReadyForPlacementID:@"b672847ed0c1a2"]) {
        return;
    }
    NSLog(@"%s", __FUNCTION__);
    UIWindow *mainWindow = nil;
    if ( @available(iOS 13.0, *) ) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
        [mainWindow makeKeyWindow];
    }else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    [[ATAdManager sharedManager] showSplashWithPlacementID:@"b672847ed0c1a2" config:[ATShowConfig new] window:mainWindow inViewController:self extra:nil delegate:self];
//    [[ATAdManager sharedManager] showSplashWithPlacementID:PlacementID scene:@"" window:mainWindow extra:nil delegate:self];
}

- (void)loadInterstitialAd {
    NSValue *size = [NSValue valueWithCGSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200)];
    NSMutableDictionary *extra = @{
        kATExtraInfoAdSizeKey: size,
        kATExtraInfoRootViewControllerKey: self,

    }.mutableCopy;  ///b67b7e8d47ce7f。 //
    
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b67bfccd4c2323" extra:extra delegate:self];
}

-(void)showInterstitialAd:(NSString *)placementID {
    if (![[ATAdManager sharedManager] interstitialReadyForPlacementID:placementID]) {
        return;
    }
    [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
//    [[ATAdManager sharedManager] showSplashWithPlacementID:PlacementID scene:@"" window:mainWindow extra:nil delegate:self];
}

#pragma mark - ATAdLoadingDelegate
/// Callback when the successful loading of the ad
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID{
    NSLog(@"topon 开屏加载完成 placementID = %@",placementID);
    [self showAd];
}

/// Callback of ad loading failure
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error{
    NSLog(@"topon 开屏加载失败 placementID = %@ error = %@",placementID,error);
}

/// Ad start bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra{
    NSLog(@"topon 开屏开始竞价 placementID = %@",placementID);
}

/// Ad bidding success
- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra{
    NSLog(@"topon 开屏竞价成功 placementID = %@",placementID);
}

/// Ad bidding fail
- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID
                                        extra:(NSDictionary*)extra
                                        error:(NSError*)error{
    NSLog(@"topon 开屏竞价失败 placementID = %@ error = %@",placementID,error);
}

#pragma mark - ATSplashDelegate

/// Splash ad displayed successfully
- (void)splashDidShowForPlacementID:(NSString *)placementID
                              extra:(NSDictionary *)extra{
    NSLog(@"topon 开屏展示 placementID = %@",placementID);
}

/// Splash ad click
- (void)splashDidClickForPlacementID:(NSString *)placementID
                               extra:(NSDictionary *)extra{
    NSLog(@"topon 开屏点击 placementID = %@",placementID);
}

/// Splash ad closed
- (void)splashDidCloseForPlacementID:(NSString *)placementID
                               extra:(NSDictionary *)extra{
    NSLog(@"topon 开屏关闭 placementID = %@",placementID);
}

- (void)splashDetailDidClosedForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra {
    NSLog(@"topon 开屏详情页关闭 placementID = %@",placementID);
}

- (void)dealloc {
    NSLog(@"释放了，%s",__FUNCTION__);
}

@end

//
//  PTGViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/5.
//

#import "PTGViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGNativeExpressFeedViewController.h"
#import "PTGNativeExpressDrawViewController.h"
#import "PTGNativeExpressBannerViewController.h"
#import "PTGNativeExpressInterstitialAdViewController.h"
#import "PTGNativeExpressRewardVideoAdViewController.h"
#import "PTGNativeViewController.h"
#import "PTGOpenURLViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ATPTGSplashViewController.h"
#import "ATPTGNativeExpressViewController.h"
#import "ATPTGBannerExpressViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "ATPTGInterstitialAdViewController.h"
#import "PTGSplashSelfRenderViewController.h"

@interface PTGViewController ()
<
PTGSplashAdDelegate,
PTGInteractiveAdDelegate,
PTGNativeExpressFullscreenVideoAdDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,strong)NSArray<NSString *> *items;
@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)PTGInteractiveAd *interactiveAd;
@property(nonatomic,strong)PTGNativeExpressFullscreenVideoAd *fullscreenVideoAd;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CLLocationManager *manager;

@end

@implementation PTGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestAlwaysAuthorization];
    [self.manager requestWhenInUseAuthorization];
    self.items = @[@"开屏",@"开屏自渲染",@"信息流",@"自渲染信息流",@"draw信息流",@"横幅",@"插屏",@"激励",@"topon开屏",@"topon信息流",@"topon横幅",@"topon插屏",@"互动",@"全屏视频"];
    [self addChildViewsAndLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                        /// 重要 影响广告填充
                        [PTGSDKManager setAdIds:@{
                            @"idfa":idfa,
                            @"caid":@"your caid",
                            @"ali_aaid": @"your ali_aaid",
                        }];
                    });
                }
                    break;
//                case ATTrackingManagerAuthorizationStatusDenied:
//                    NSLog(@"用户拒绝了跟踪请求");
//                    break;
//                case ATTrackingManagerAuthorizationStatusRestricted:
//                    NSLog(@"跟踪权限受限");
//                    break;
//                case ATTrackingManagerAuthorizationStatusNotDetermined:
//                    NSLog(@"用户尚未选择");
//                    break;
                default:
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self initAdSDK];
                    });
                    break;
            }
        }];
    }
}

- (void)addChildViewsAndLayout {
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    [splashAd showAdWithViewController:self];
}

/// 开屏加载失败
- (void)ptg_splashAd:(PTGSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"开屏广告请求失败%@",error);
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

#pragma mark - PTGInteractiveAdDelegate -
///  广告加载成功 广告场景内的广告加载成功
- (void)ptg_interactiveAdDidLoad:(PTGInteractiveAd *)interactiveAd {
    NSLog(@"互动广告加载成功%s",__func__);
}

/// 广告加载失败 广告场景内的广告加载失败
- (void)ptg_interactiveAd:(PTGInteractiveAd *)interactiveAd didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"互动广告加载失败%@",error);
}

/// 广告将要曝光 广告场景内的广告将要展示
- (void)ptg_interactiveAdWillBecomVisible:(PTGInteractiveAd *)interactiveAd {
    NSLog(@"互动广告展示%s",__func__);
}

/// 广告被点击  广告场景内的广告被点击
- (void)ptg_interactiveAdDidClick:(PTGInteractiveAd *)interactiveAd {
    NSLog(@"互动广告被点击%s",__func__);
}

/// 广告被关闭 广告场景内的广告被关闭
- (void)ptg_interactiveAdClosed:(PTGInteractiveAd *)interactiveAd {
    NSLog(@"互动广告被关闭%s",__func__);
}

/// 广告详情页给关闭 广告场景内的广告详情页被关闭
- (void)ptg_interactiveAdViewDidCloseOtherController:(PTGInteractiveAd *)interactiveAd {
    NSLog(@"互动广告详情页被关闭%s",__func__);
}

///  互动广告页面关闭 广告场景被关闭
- (void)ptg_interactiveAdClosedAdPage:(PTGInteractiveAd *)interactiveAd  {
    NSLog(@"互动广告场景被关闭%s",__func__);
}

#pragma mark - PTGNativeExpressFullscreenVideoAdDelegate -
/// 广告加载成功
/// @param fullscreenVideoAd 广告实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidLoad:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    [fullscreenVideoAd showAdFromRootViewController:self];
    NSLog(@"全屏视频广告加载成功");
}

/// 广告加载实例
/// @param fullscreenVideoAd 广告实例
/// @param error 错误
- (void)ptg_nativeExpressFullscreenVideoAd:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"全屏视频广告加载失败,%@",error);
}

/// 全屏视频广告已经展示
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidVisible:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"全屏视频广告展示");
}

/// 全屏视频广告点击
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidClick:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"全屏视频广告点击");
}

///全屏视频广告关闭
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidClose:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"全屏视频广告关闭");
}

/// 全屏视频广告详情页关闭
/// @param fullscreenVideoAd 实例对象
- (void)ptg_nativeExpressFullscreenVideoAdDidCloseOtherController:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"全屏视频广告详情页关闭");
}

///  全屏视频广告播放失败
- (void)ptg_nativeExpressFullscreenVideoAdDidPlayFinish:(PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"全屏视频广告播放失败");
}

#pragma mark - UITableViewDelegate,UITableViewDataSourc -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        [self.splashAd loadAd];
    }
    else if(indexPath.row == 1) {
        PTGSplashSelfRenderViewController *vc = [[PTGSplashSelfRenderViewController alloc] init];
        viewController = vc;
    } else if(indexPath.row == 2) {
        PTGNativeExpressFeedViewController *vc = [[PTGNativeExpressFeedViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeFeed;
        viewController = vc;
    } else if(indexPath.row == 3) {
        PTGNativeExpressFeedViewController *vc = [[PTGNativeExpressFeedViewController alloc] init];
        vc.type = PTGNativeExpressAdTypeSelfRender;
        viewController = vc;
    } else if(indexPath.row == 4) {
        viewController = [[PTGNativeExpressDrawViewController alloc] init];
    } else if(indexPath.row == 5) {
        viewController = [[PTGNativeExpressBannerViewController alloc] init];
    } else if(indexPath.row == 6) {
        viewController = [[PTGNativeExpressInterstitialAdViewController alloc] init];
    } else if (indexPath.row == 7) {
        viewController = [[PTGNativeExpressRewardVideoAdViewController alloc] init];
    } else if (indexPath.row == 8) {
        ATPTGSplashViewController *vc = [[ATPTGSplashViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 9) {
//        ATPTGNativeExpressViewController *vc = [[ATPTGNativeExpressViewController alloc] init];
//        viewController = vc;
    } else if (indexPath.row == 10) {
        ATPTGBannerExpressViewController *vc = [[ATPTGBannerExpressViewController alloc] init];
        viewController = vc;
    } else if (indexPath.row == 11) {
        ATPTGInterstitialAdViewController *vc = [[ATPTGInterstitialAdViewController alloc] init];
        viewController = vc;
    }  else if (indexPath.row == 12){
        // 互动广告打开广告场景
        [self.interactiveAd openAdPage];
    } else if (indexPath.row == 13) {
        [self.fullscreenVideoAd loadAd];
    } else {
////        [self.nativeExpressSplashView loadAdData];
//        viewController = [[PTGOpenURLViewController alloc] init];
    }
    viewController ? [self.navigationController pushViewController:viewController animated:YES] : nil;
}

#pragma mark - get -
- (PTGSplashAd *)splashAd {
    if (!_splashAd) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
        bottomView.backgroundColor = [UIColor whiteColor];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
        logo.accessibilityIdentifier = @"splash_logo";
        logo.frame = CGRectMake(0, 0, 311, 47);
        logo.center = bottomView.center;
        [bottomView addSubview:logo];
        
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900000397"];
        _splashAd.delegate = self;
        _splashAd.rootViewController = self;
        _splashAd.bottomView = bottomView;
    }
    return _splashAd;
}

- (PTGInteractiveAd *)interactiveAd {
    if (!_interactiveAd) {
        _interactiveAd = [[PTGInteractiveAd alloc] initWithPlacementId:@"900000405"];
        _interactiveAd.delegate = self;
        _interactiveAd.viewController = self;
    }
    return _interactiveAd;
}

- (PTGNativeExpressFullscreenVideoAd *)fullscreenVideoAd  {
    if (!_fullscreenVideoAd) {
        _fullscreenVideoAd = [[PTGNativeExpressFullscreenVideoAd alloc] initWithPlacementId:@"900000402"];
        _fullscreenVideoAd.delegate = self;
    }
    return _fullscreenVideoAd;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}


@end

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


@interface PTGViewController ()<PTGSplashAdDelegate,PTGInteractiveAdDelegate>

@property(nonatomic,strong)NSArray<UIButton *> *buttons;
@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)PTGInteractiveAd *interactiveAd;

@end

@implementation PTGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    
    CGFloat gap = 20;
    CGFloat width = 150;
    CGFloat height = 30;
    CGFloat topMargin = (self.view.bounds.size.height - (gap + height) * self.buttons.count - gap) / 2.0;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(topMargin + idx * (gap + height));
            make.left.equalTo(self.view).offset(50);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
    }];
}

#pragma mark - action -
- (void)buttonClicked:(UIButton *)sender {
    UIViewController *viewController = nil;
    if (sender.tag == 0) {
        [self.splashAd loadAd];
    } else if(sender.tag == 1) {
        viewController = [[PTGNativeExpressFeedViewController alloc] init];
    } else if(sender.tag == 2) {
        viewController = [[PTGNativeExpressDrawViewController alloc] init];
    } else if(sender.tag == 3) {
        viewController = [[PTGNativeExpressBannerViewController alloc] init];
    } else if(sender.tag == 4) {
        viewController = [[PTGNativeExpressInterstitialAdViewController alloc] init];
    } else if (sender.tag == 5) {
        viewController = [[PTGNativeExpressRewardVideoAdViewController alloc] init];
    } else if (sender.tag == 6 || sender.tag == 7 || sender.tag == 8) {
        PTGNativeViewController *vc = [[PTGNativeViewController alloc] init];
        vc.type = sender.tag;
        viewController = vc;
    } else {
        // 互动广告打开广告场景
        [self.interactiveAd openAdPage];
    }
    viewController ? [self.navigationController pushViewController:viewController animated:YES] : nil;
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
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

/// 开屏广告详情页面关闭的回调
- (void)ptg_splashAdDidCloseOtherController:(PTGSplashAd *)splashAd {
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

#pragma mark - get -
- (PTGSplashAd *)splashAd {
    if (!_splashAd) {
        _splashAd = [[PTGSplashAd alloc] initWithPlacementId:@"900000228"];
        _splashAd.delegate = self;
        _splashAd.rootViewController = self;
    }
    return _splashAd;
}

- (PTGInteractiveAd *)interactiveAd {
    if (!_interactiveAd) {
        _interactiveAd = [[PTGInteractiveAd alloc] initWithPlacementId:@"900000245"];
        _interactiveAd.delegate = self;
        _interactiveAd.viewController = self;
    }
    return _interactiveAd;
}

- (NSArray *)buttons {
    if (!_buttons) {
        NSMutableArray *buttonsM = [[NSMutableArray alloc] init];
        [@[@"开屏",@"信息流",@"draw信息流",@"横幅",@"插屏",@"激励",@"文字链上下滚动",@"文字链左右滚动",@"浮窗",@"互动"] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setBackgroundColor:UIColor.lightGrayColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            [buttonsM addObject:button];
        }];
        _buttons = buttonsM.copy;
    }
    return _buttons;
}

@end

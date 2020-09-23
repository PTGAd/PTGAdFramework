//
//  RewardVideoViewController.m
//  GDTMobApp
//
//  Created by royqpwang on 2018/9/5.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "PTGRewardVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <PTGAdSDK/PTGAdSDK.h>

static NSString *PORTRAIT_AD_PLACEMENTID = @"880";
static NSString *PORTRAIT_LANDSCAPE_AD_PLACEMENTID = @"881";
@interface PTGRewardVideoViewController () <UIScrollViewDelegate,PTGRewardedVideoAdDelegate>
//GDTRewardedVideoAdDelegate
@property (nonatomic, strong) PTGRewardedVideoAd *rewardVideoAd;
@property (weak, nonatomic) IBOutlet UITextField *placementIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, assign) UIInterfaceOrientation supportOrientation;
@property (weak, nonatomic) IBOutlet UIButton *portraitButton;


@property (nonatomic, strong) UIAlertController *changePosIdController;
@property (nonatomic, strong) UIAlertAction *portraitAdIdAction;

@end

@implementation PTGRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}



- (void)clickBackToMainView {
    NSArray *arrayViews = [UIApplication sharedApplication].keyWindow.subviews;
    UIView *backToMainView = [[UIView alloc] init];
    for (int i = 1; i < arrayViews.count; i++) {
        NSString *viewNameStr = [NSString stringWithFormat:@"%s",object_getClassName(arrayViews[i])];
        if ([viewNameStr isEqualToString:@"UITransitionView"]) {
            backToMainView = [arrayViews[i] subviews][0];
            break;
        }
    }
    backToMainView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap)];
    [backToMainView addGestureRecognizer:backTap];
}

- (void)backTap {
    [self.changePosIdController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (IBAction)loadAd:(id)sender {
    NSString *placementId = self.placementIdTextField.text.length > 0 ?self.placementIdTextField.text: self.placementIdTextField.placeholder;
    //placementId = @"1040149434136928";
    self.rewardVideoAd = [[PTGRewardedVideoAd alloc] initWithPlacementId:placementId];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
}

- (IBAction)playVideo:(UIButton *)sender {

    [self.rewardVideoAd showRootViewController:self];
}

- (IBAction)changeOrientation:(UIButton *)sender {
    // 仅为方便调试提供的逻辑，应用接入流程中不需要设置方向
    if ([self.placementIdTextField.placeholder isEqualToString:PORTRAIT_AD_PLACEMENTID]) {
        self.placementIdTextField.placeholder  = PORTRAIT_LANDSCAPE_AD_PLACEMENTID;
    } else {
        self.placementIdTextField.placeholder = PORTRAIT_AD_PLACEMENTID;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - GDTRewardVideoAdDelegate



- (void)rewardVideoAdDidLoad:(NSObject *)rewardedVideoAd{
    //
    NSLog(@"%s",__FUNCTION__);

       self.statusLabel.text = [NSString stringWithFormat:@" 广告数据加载成功"];

}

- (void)rewardVideoAdVideoDidLoad:(NSObject *)rewardedVideoAd;
{
    NSLog(@"%s",__FUNCTION__);

}






- (void)gdt_rewardVideoAdVideoDidLoad:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
//    self.statusLabel.text = [NSString stringWithFormat:@"%@ 视频文件加载成功", rewardedVideoAd.adNetworkName];
}


- (void)gdt_rewardVideoAdWillVisible:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"视频播放页即将打开");
}

- (void)gdt_rewardVideoAdDidExposed:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
//    self.statusLabel.text = [NSString stringWithFormat:@"%@ 广告已曝光", rewardedVideoAd.adNetworkName];
    NSLog(@"广告已曝光");
}

- (void)gdt_rewardVideoAdDidClose:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
//    self.statusLabel.text = [NSString stringWithFormat:@"%@ 广告已关闭", rewardedVideoAd.adNetworkName];
////    广告关闭后释放ad对象
//    self.rewardVideoAd = nil;
    NSLog(@"广告已关闭");
}


- (void)gdt_rewardVideoAdDidClicked:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
//    self.statusLabel.text = [NSString stringWithFormat:@"%@ 广告已点击", rewardedVideoAd.adNetworkName];
    NSLog(@"广告已点击");
}

- (void)gdt_rewardVideoAd:(NSObject *)rewardedVideoAd didFailWithError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    if (error.code == 4014) {
        NSLog(@"请拉取到广告后再调用展示接口");
        self.statusLabel.text = @"请拉取到广告后再调用展示接口";
    } else if (error.code == 4016) {
        NSLog(@"应用方向与广告位支持方向不一致");
        self.statusLabel.text = @"应用方向与广告位支持方向不一致";
    } else if (error.code == 5012) {
        NSLog(@"广告已过期");
        self.statusLabel.text = @"广告已过期";
    } else if (error.code == 4015) {
        NSLog(@"广告已经播放过，请重新拉取");
        self.statusLabel.text = @"广告已经播放过，请重新拉取";
    } else if (error.code == 5002) {
        NSLog(@"视频下载失败");
        self.statusLabel.text = @"视频下载失败";
    } else if (error.code == 5003) {
        NSLog(@"视频播放失败");
        self.statusLabel.text = @"视频播放失败";
    } else if (error.code == 5004) {
        NSLog(@"没有合适的广告");
        self.statusLabel.text = @"没有合适的广告";
    } else if (error.code == 5013) {
        NSLog(@"请求太频繁，请稍后再试");
        self.statusLabel.text = @"请求太频繁，请稍后再试";
    } else if (error.code == 3002) {
        NSLog(@"网络连接超时");
        self.statusLabel.text = @"网络连接超时";
    } else if (error.code == 5027){
        NSLog(@"页面加载失败");
        self.statusLabel.text = @"页面加载失败";
    }
    NSLog(@"ERROR: %@", error);
}

- (void)gdt_rewardVideoAdDidRewardEffective:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"播放达到激励条件");
}

- (void)gdt_rewardVideoAdDidPlayFinish:(NSObject *)rewardedVideoAd
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"视频播放结束");
    
    
}

@end

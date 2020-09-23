//
//  UnifiedBannerViewController.m
//  GDTMobApp
//
//  Created by nimomeng on 2019/3/7.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "PTGBannerViewController.h"
//#import "GDTUnifiedBannerView.h"
//#import "GDTAppDelegate.h"
#import <PTGAdSDK/PTGAdSDK.h>

@interface PTGBannerViewController () <PTGExpressBannerViewDelegate>
@property (nonatomic, strong) PTGBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UITextField *placementIdText;
//@property (weak, nonatomic) IBOutlet UITextField *refreshIntervalText;
//@property (weak, nonatomic) IBOutlet UISwitch *animationSwitch;

@end

@implementation PTGBannerViewController

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAdAndShow:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)loadAdAndShow:(id)sender {
    if (self.bannerView.superview) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
    [self.view addSubview:self.bannerView];
    [self.bannerView loadAdData];
}

- (IBAction)removeAd:(id)sender {
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
}

#pragma mark - property getter
- (PTGBannerView *)bannerView
{
    if (!_bannerView) {
        CGRect rect = {CGPointMake(0, 0), CGSizeMake(375, 60)};
        _bannerView = [[PTGBannerView alloc]
                       initWithFrame:rect
                       placementId:self.placementIdText.text.length > 0 ? self.placementIdText.text: self.placementIdText.placeholder
                       viewController:self];
        _bannerView.accessibilityIdentifier = @"banner_ad";
        _bannerView.delegate = self;
    }
    return _bannerView;
}

#pragma mark - PTGExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(UIView *)bannerAdView{

}


- (void)nativeExpressBannerAdView:(UIView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error{
    
}


- (void)nativeExpressBannerAdViewRenderSuccess:(UIView *)bannerAdView{
    
}


- (void)nativeExpressBannerAdViewRenderFail:(UIView *)bannerAdView error:(NSError * __nullable)error{
    
}

- (void)nativeExpressBannerAdViewDidClick:(UIView *)bannerAdView{
    
}

- (void)nativeExpressBannerAdViewDidClose:(UIView *)bannerAdView{
    
}



@end



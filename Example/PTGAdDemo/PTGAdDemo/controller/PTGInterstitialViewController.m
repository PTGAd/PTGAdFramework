//
//  PTGInterstitialViewController.m
//  PTGAdSDK_Example
//
//  Created by admin on 2020/9/14.
//  Copyright © 2020 yingzhao.fyz. All rights reserved.
//

#import "PTGInterstitialViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGNormalButton.h"
@interface PTGInterstitialViewController ()<PTGInterstitialAdDelegate>
@property (nonatomic, strong) PTGInterstitialAd *interstitialAd;

@end

@implementation PTGInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
        self.view.backgroundColor = [UIColor whiteColor];
       CGSize size = [UIScreen mainScreen].bounds.size;
       
       NSArray *sizeAry = @[@(PTGProposalSize_Interstitial600_400), @(PTGProposalSize_Interstitial600_600), @(PTGProposalSize_Interstitial600_900)];
       NSArray *stringAry = @[@"600:400", @"600:600", @"600:900"];
       NSInteger count = sizeAry.count;
       CGFloat widht = size.width;
       CGFloat height = size.height;
       CGFloat itemHeight = 44;
       CGFloat xOffset = 40;
       CGFloat itemWidth = widht - xOffset * 2;
       CGFloat yStep = height / (count + 1);
       
       for (NSInteger i = 0; i < count; i++) {
           CGFloat y = yStep * (i + 1);
           PTGNormalButton *button = [[PTGNormalButton alloc] initWithFrame:CGRectMake(xOffset, y, itemWidth, itemHeight)];
           button.showRefreshIncon = YES;
           NSString *text = [NSString stringWithFormat:@"%@-%@", @"插屏", stringAry[i]];
           [button setTitle:text forState:UIControlStateNormal];
           button.tag = [sizeAry[i] integerValue];
           [button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
           [self.view addSubview:button];
       }
    
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)buttonTapped:(UIButton *)sender {
    PTGProposalSize proposalSize = sender.tag;
    [self loadAndShowWithBUProposalSize:proposalSize];
}
//BUDExpressInterstitialViewController


- (void)loadAndShowWithBUProposalSize:(PTGProposalSize)proposalSize {
    self.interstitialAd = [[PTGInterstitialAd alloc] initWithPlacementId:@"650" size:proposalSize];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)interstitialAdDidClose:(NSObject *)interstitialAd {
}


- (void)interstitialAdDidLoad:(NSObject *)interstitialAd {
    [self.interstitialAd showRootViewController:self.navigationController];
}
- (void)interstitialAd:(NSObject *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}




@end

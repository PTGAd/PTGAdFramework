//
//  ViewController.m
//  PTGAdFrameworkDeom
//
//  Created by admin on 2020/8/24.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ViewController.h"
#import "NativeExpressAdViewController.h"
#import <PTGAdSDK/PTGSplashA.h>

@interface ViewController ()<PTGSplashAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn14;
@property (weak, nonatomic) IBOutlet UIButton *btn15;
@property (weak, nonatomic) IBOutlet UIButton *btn16;
@property (weak, nonatomic) IBOutlet UIButton *btn17;
@property (weak, nonatomic) IBOutlet UIButton *btn18;
@property (nonatomic, strong) PTGSplashA *nativeExpressAd;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PTGAdSDK开发";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn14Click:(id)sender {
    [self showSplash:0];
}

- (IBAction)btn15Click:(id)sender {
    [self showSplash:1];
}

- (IBAction)btn16Click:(id)sender {
    [self showSplash:2];
}

- (IBAction)btn17Click:(id)sender {
    [self showSplash:3];
}

- (IBAction)cumtomClick:(id)sender {
    [self showSplash:4];
}
- (IBAction)btn18Click:(id)sender {
    //左图下文
    [self showSplashFlow:4];
}

- (void)showSplash:(NSInteger)index {
    //id 989
//    [PTGAdSDKManager testUseAd:index];
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashLogo"]];
    logo.accessibilityIdentifier = @"splash_logo";
    logo.frame = CGRectMake(0, 0, 311, 47);
    logo.center = bottomView.center;
    [bottomView addSubview:logo];

    self.nativeExpressAd = [[PTGSplashA alloc] initWithPlacementId:@"989" bottomView:bottomView];
    self.nativeExpressAd.delegate = self;
    self.nativeExpressAd.hideSkipButton = false;
    
    
//    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
//    self.nativeExpressAd.keyWindow = fK;
    [self.nativeExpressAd loadAd];
    
    

}







- (void)showSplashFlow:(NSInteger)index {
//
    NativeExpressAdViewController *VC =  [[NativeExpressAdViewController alloc] initWithNibName:@"NativeExpressAdViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:true];

}

#pragma mark - PTGSplashAdDelegate

- (void)splashAdDidLoad:(NSObject *)splashAd{
    
}
- (void)splashAdDidCloseOtherController:(NSObject *)splashAd{
    NSLog(@"走了");
}

@end

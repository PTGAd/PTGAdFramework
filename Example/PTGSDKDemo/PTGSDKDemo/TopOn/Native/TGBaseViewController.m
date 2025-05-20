//
//  TGBaseViewController.m
//  AncloudCam
//
//  Created by Darren on 2024/9/10.
//  Copyright © 2024 eye. All rights reserved.
//

#import "TGBaseViewController.h"
#import "TGOrientationTool.h"
#import "TGCustomDefine.h"

@interface TGBaseViewController ()

@end

@implementation TGBaseViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@销毁",NSStringFromClass([self class]));
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [TGOrientationTool appRotateToOrientation:UIInterfaceOrientationPortrait controller:self];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self preferredStatusBarStyle];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear",NSStringFromClass([self class]));
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavigationBar{
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏标题颜色、字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:TG_OEMBlackColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    //设置导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    //设置导航栏item字体颜色
    self.navigationController.navigationBar.tintColor = TG_OEMBlackColor;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
        //背景色
        navBarAppearance.backgroundColor = self.navigationController.navigationBar.barTintColor;
        //去掉半透明效果
        navBarAppearance.backgroundEffect = nil;
        //去除导航栏阴影
        navBarAppearance.shadowColor = [UIColor clearColor];
        navBarAppearance.shadowImage = [[UIImage alloc] init];
        navBarAppearance.backgroundImage = [[UIImage alloc] init];
        //字体颜色
        navBarAppearance.titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
        self.navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance;
        self.navigationController.navigationBar.standardAppearance = navBarAppearance;
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification{
    NSLog(@"%@ applicationDidEnterBackground",NSStringFromClass([self class]));
}

- (void)applicationWillEnterForeground:(NSNotification *)notification{
    NSLog(@"%@ applicationWillEnterForeground",NSStringFromClass([self class]));
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    NSLog(@"%@ applicationWillResignActive",NSStringFromClass([self class]));
}

- (void)applicationDidBecomeActive:(NSNotification *)notification{
    NSLog(@"%@ applicationDidBecomeActive",NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

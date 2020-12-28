//
//  NativeExpressAdViewController.m
//  GDTMobApp
//
//  Created by michaelxing on 2017/4/17.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import "NativeExpressAdViewController.h"
#import <PTGAdSDK/PTGAdSDK.h>
//#import "GDTAppDelegate.h"
//#import "NativeExpressAdConfigView.h"


@interface NativeExpressAdViewController ()<UITableViewDelegate,UITableViewDataSource,PTGNativeExpressAdDelegete>

@property (nonatomic, strong) NSMutableArray *expressAdViews;

@property (nonatomic, strong) PTGNativeExpressAd *nativeExpressAd;


@property (weak, nonatomic) IBOutlet UITextField *placementIdTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic)  float widthSliderValue;
@property (assign, nonatomic)  float heightSliderValue;
@property (assign, nonatomic)  float adCountSliderValue;

//切换广告样式
@property (nonatomic, strong) UIAlertController *advStyleAlertController;

@property (nonatomic, strong) UIButton *changAdvStyleButton;

@end

@implementation NativeExpressAdViewController

static NSString *ABOVEPH_BLOWTEXT_STR = @"458";

static NSString *ABOVETEXT_BLOW_PH_STR = @"8010090333885456";

static NSString *LEFTPH_RIHGTTEXT_STR = @"1080793303881448";

static NSString *LEFTTEXT_RIGHTPH_STR = @"9050097313684512";

static NSString *TWOPH_AND_TEXT_STR = @"5070297373087567";

static NSString *WIDTHPHOTO_STR = @"5070791337820394";

static NSString *HEIGHTPHOTO_STR = @"6090492353182599";

static NSString *THREE_SMALLPH_STR = @"9050492343889611";

static NSString *ABOVETEXT_SURFACE_BLOWPH_STR = @"9010495393982624";

static NSString *ABOVEPH_BLOWTEXT_SURFACE_STR = @"6020493353488605";

static NSString *TEXTSURFACE_ONEPHOTO_STR = @"3030690323789618";

static NSString *HEIGHTERPHOTO_STR = @"6060290383380659";

static NSInteger ADVTYPE_COUNT = 7;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"splitnativeexpresscell"];
    
    [self initVideoConfig];
//    self.changAdvStyleButton.hidden = true;
    
    self.placementIdTextField.placeholder = @"457";
    
//    self.placementIdTextField.placeholder = @"458";
//    self.placementIdTextField.placeholder = @"100014";
    self.expressAdViews = [NSMutableArray array];
    [self refreshViewWithNewPosID];
}

- (IBAction)selectADVStyle:(id)sender {
    self.advStyleAlertController = [UIAlertController alertControllerWithTitle:@"请选择需要的广告样式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *advTypeTextArray = @[@"左图右文",
                                  @"左文右图",
                                  @"上文下图",
                                  @"上文下图浮层",
                                  @"上图下文",
                                  @"文字浮层",
                                  @"三小图(图片尺寸228×150)"
                                  ];
    
    NSArray *advTypePosIDArray = @[@"458",@"459",@"460",@"461",@"462",@"463",@"464"];
    __weak typeof (self) weakSelf = self;

    for (NSInteger i = 0; i < ADVTYPE_COUNT; i++) {
        UIAlertAction *advTypeAction = [UIAlertAction actionWithTitle:advTypeTextArray[i]
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.placementIdTextField.placeholder = advTypePosIDArray[i];
            //
            [weakSelf clearData];
            [weakSelf refreshViewWithNewPosID];
        }];
        [self.advStyleAlertController addAction:advTypeAction];
    }
    [self presentViewController:self.advStyleAlertController
                       animated:YES
                     completion:^{
        [weakSelf clickBackToMainView];
    }];
}
- (void)clearData {
    //placementId 变化清楚数据 从新初始化
    //如果有多样式需求 测试用 正常一个id就行
    self.expressAdViews  = [NSMutableArray array];
    self.nativeExpressAd = nil;
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
//    UIView *backToMainView = [arrayViews.lastObject subviews][0];
    backToMainView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap)];
    [backToMainView addGestureRecognizer:backTap];
}

- (void)backTap {
    [self.advStyleAlertController dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshViewWithNewPosID {
    self.adCountSliderValue = 1;
    NSString *placementId = self.placementIdTextField.text.length > 0? self.placementIdTextField.text: self.placementIdTextField.placeholder;
    
    if (self.nativeExpressAd == nil) {
        self.nativeExpressAd =  [[PTGNativeExpressAd alloc] initWithPlacementId:placementId type:1 adSize:CGSizeMake(self.view.frame.size.width , 0)];
//        self.nativeExpressAd = [[PTGNativeExpressAd alloc] initWithPlacementId:placementId adSize:CGSizeMake(self.view.frame.size.width , 0)];
        self.nativeExpressAd.delegate = self;
//        [self.nativeExpressAd dataCorrectionHandler:^(BOOL result, NSArray * _Nonnull views) {
//        }];
    }
     [self.nativeExpressAd loadAdData];
  
    
}


- (IBAction)refreshButton:(id)sender {
    [self refreshViewWithNewPosID];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)initVideoConfig
{
    self.widthSliderValue = [UIScreen mainScreen].bounds.size.width;
    self.heightSliderValue = 180;
    self.adCountSliderValue = 3;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多视频配置" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToAnotherView)];
}

- (void)jumpToAnotherView{
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}

#pragma mark - PTGNativeExpressAdDelegete
/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(NSObject *)nativeExpressAd views:(NSArray<__kindof UIView *> *)views{
//    [self.expressAdViews addObjectsFromArray:views];
    self.expressAdViews = [NSMutableArray arrayWithArray:views];
    if (self.expressAdViews.count) {
        [self.expressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.nativeExpressAd render:obj controller:self];
           
        }];
    }
    
    
    [self.tableView reloadData];
}
- (void)nativeExpressAdFailToLoad:(NSObject *)nativeExpressAd error:(NSError *)error{
    
    self.expressAdViews = [NSMutableArray array];
    [self.tableView reloadData];
}



- (void)nativeExpressAdViewClicked:(UIView *)nativeExpressAdView
{
    
    
}

- (void)nativeExpressAdViewClosed:(UIView *)nativeExpressAdView
{
    [self.expressAdViews removeObject:nativeExpressAdView];
    [self.tableView reloadData];
}

- (void)nativeExpressAdViewExposure:(UIView *)nativeExpressAdView
{
}

 

- (void)nativeExpressAdViewDidDismissScreen:(UIView *)nativeExpressAdView
{
    [self.expressAdViews removeObject:nativeExpressAdView];
    [self.tableView reloadData];
}
- (void)nativeExpressAdViewRenderSuccess:(UIView *)nativeExpressAdView{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        return view.bounds.size.height;
    }
    else {
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % 2 == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"nativeexpresscell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
//        cell.backgroundColor = [UIColor orangeColor];

        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        view.tag = 1000;
        [cell.contentView addSubview:view];
        cell.accessibilityIdentifier = @"nativeTemp_even_ad";
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"splitnativeexpresscell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor grayColor];
        cell.accessibilityIdentifier = @"nativeTemp_odd_ad";
    }
    return cell;
}

- (void)dealloc
{
    //
    
}


@end

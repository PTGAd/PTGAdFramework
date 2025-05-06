//
//  ATNativeExpressCustomViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/11/11.
//
#define kScreenW ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? UIScreen.mainScreen.bounds.size.width : UIScreen.mainScreen.bounds.size.height)
#define kNavigationBarHeight ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? ([[UIApplication sharedApplication]statusBarFrame].size.height + 44) : ([[UIApplication sharedApplication]statusBarFrame].size.height - 4))

//#define kScreenH UIScreen.mainScreen.bounds.size.height
#define kScreenH ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? UIScreen.mainScreen.bounds.size.height : UIScreen.mainScreen.bounds.size.width)

//#define kScreenW UIScreen.mainScreen.bounds.size.width
#define kScreenW ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? UIScreen.mainScreen.bounds.size.width : UIScreen.mainScreen.bounds.size.height)

//#define kScaleW(x) UIScreen.mainScreen.bounds.size.width / 750 * x
#define kScaleW(x) (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) ? (UIScreen.mainScreen.bounds.size.width / 750 * x) : (UIScreen.mainScreen.bounds.size.height / 750 * x))

#import "ATPTGNativeExpressViewController.h"
#import <AnyThinkNative/AnyThinkNative.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import "ATNativeRenderView.h"

@interface ATPTGNativeExpressViewController ()<ATNativeADDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<ATNativeADView *> *ads;
@end

@implementation ATPTGNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ads = [NSMutableArray new];
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"Native";
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 150, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 150);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width - 100)/2, UIScreen.mainScreen.bounds.size.height - 100, 100, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"loadAd" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)loadAd{
    NSLog(@"%s", __FUNCTION__);
    NSValue *size = [NSValue valueWithCGSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200)];
    NSMutableDictionary *extra = @{
        kATExtraInfoNativeAdSizeKey: size
    }.mutableCopy;  ///b67b7e8d47ce7f。 //
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b6728481ee50a5" extra:extra delegate:self];
}

- (ATNativeADConfiguration *)getNativeADConfiguration{
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.delegate = self;
    config.rootViewController = self;
    config.sizeToFit = YES;
    return config;
}

- (ATNativeADView *)getNativeADView:(NSString *)placementID nativeAdOffer:(ATNativeAdOffer *)offer {
    ATNativeADConfiguration *config = [self getNativeADConfiguration];
    ATNativeADView *nativeADView = [[ATNativeADView alloc]initWithConfiguration:config currentOffer:offer placementID:placementID];
    [offer rendererWithConfiguration:config selfRenderView:nil nativeADView:nativeADView];
    return nativeADView;
}

/// Callback when the successful loading of the ad
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"topon信息流加载成功");
    ATNativeAdOffer *offer = [[ATAdManager sharedManager] getNativeAdOfferWithPlacementID:placementID];
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.mediaViewFrame = CGRectZero;
    config.delegate = self;
    config.rootViewController = self;
    config.sizeToFit = YES;
    if (offer.nativeAd.isExpressAd) {
        ATNativeADView *adView = [self getNativeADView:placementID nativeAdOffer:offer];
        [offer rendererWithConfiguration:config selfRenderView:nil nativeADView:adView];
        [self.ads addObject:adView];
        [self.tableView reloadData];
    } else {
        ATNativeRenderView *nativeADView = [[ATNativeRenderView alloc]initWithConfiguration:config currentOffer:offer placementID:@"b6728481ee50a5"];
        [nativeADView registerClickableViewArray:@[nativeADView]];
        nativeADView.frame = CGRectMake(0, 0, kScreenW, [ATNativeRenderView heightWithOffer:offer.nativeAd]);
        [nativeADView updateAdViewConfiguration:config currentOffer:offer placementID:@"b6728481ee50a5"];
        [offer rendererWithConfiguration:config selfRenderView:nil nativeADView:nativeADView];
        [self.ads addObject:nativeADView];
        [self.tableView reloadData];
    }
}

/// Callback of ad loading failure
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error {
    NSLog(@"topon信息流加载失败");
    
}

/// Ad start load
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {

    
}
/// Ad load success
- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    

}
/// Ad load fail
- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID
                                       extra:(NSDictionary*)extra
                                       error:(NSError*)error {
    
}

/// Ad start bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID
                                         extra:(NSDictionary*)extra {
    NSLog(@"topon信息流开始竞价，placementID = %@",placementID);
    
}

/// Ad bidding success
- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID
                                          extra:(NSDictionary*)extra {
    NSLog(@"topon信息流竞价成功，placementID = %@",placementID);
    
}

/// Ad bidding fail
- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID
                                        extra:(NSDictionary*)extra
                                        error:(NSError*)error {
    NSLog(@"topon信息流竞价失败，placementID = %@",placementID);
    
}

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra { 
    
}


- (void)didClickNativeAdInAdView:(nonnull ATNativeADView *)adView placementID:(nonnull NSString *)placementID extra:(nonnull NSDictionary *)extra { 
    NSLog(@"topon信息流广告点击");
}

- (void)didShowNativeAdInAdView:(nonnull ATNativeADView *)adView placementID:(nonnull NSString *)placementID extra:(nonnull NSDictionary *)extra { 
    NSLog(@"topon信息流展示");
}

- (void)didTapCloseButtonInAdView:(ATNativeADView *)adView
                      placementID:(NSString *)placementID
                            extra:(NSDictionary *)extra {
    
    NSLog(@"topon信息流关闭");
    [self.ads removeObject:adView];
    [self.tableView reloadData];
}

- (void)didCloseDetailInAdView:(ATNativeADView *)adView
                   placementID:(NSString *)placementID
                         extra:(NSDictionary *)extra {
    NSLog(@"topon信息详情页关闭");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"ad count = %ld",self.ads.count);
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATNativeExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATNativeExpressCell" forIndexPath:indexPath];
    cell.adView = self.ads[indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  self.ads[indexPath.row].bounds.size.height;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        [_tableView registerClass:ATNativeExpressCell.class forCellReuseIdentifier:@"ATNativeExpressCell"];
    }
    return _tableView;
}

@end


@implementation ATNativeExpressCell

- (void)setAdView:(ATNativeADView *)adView {
    _adView = adView;
    NSArray<UIView *> *subviews = self.contentView.subviews;
    [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:ATNativeADView.class]) {
            [obj removeFromSuperview];
        }
    }];
    [self.contentView addSubview:adView];
    
    if (!adView.nativeAd.isExpressAd) {
        /// topon 会渲染一个ATNetworkNativeTemplateView
        [adView.selfRenderView removeFromSuperview];
    }
}

@end


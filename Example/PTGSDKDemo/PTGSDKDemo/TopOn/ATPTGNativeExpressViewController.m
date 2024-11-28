//
//  ATNativeExpressCustomViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/11/11.
//
#define kScreenW ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? UIScreen.mainScreen.bounds.size.width : UIScreen.mainScreen.bounds.size.height)

#import "ATPTGNativeExpressViewController.h"
#import <AnyThinkNative/AnyThinkNative.h>

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
    NSDictionary *extra = @{
        kATExtraInfoNativeAdSizeKey: size,
        kATExtraInfoRootViewControllerKey: self
    };
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b6728481ee50a5" extra:extra delegate:self];
}

- (ATNativeADConfiguration *)getNativeADConfiguration{
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.delegate = self;
    config.rootViewController = self;
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
    ATNativeADView *adView = [self getNativeADView:placementID nativeAdOffer:offer];
    if (adView) {
        [self.ads addObject:adView];
        NSLog(@"ad count = %d",self.ads.count);
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"ad count = %d",self.ads.count);
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
}

@end

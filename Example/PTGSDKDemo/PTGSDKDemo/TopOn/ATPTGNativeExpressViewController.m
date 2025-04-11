//
//  ATNativeExpressCustomViewController.m
//  PTGSDKDemo
//
//  Created byttt on 2024/11/11.
//
#define kScreenW ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown ? UIScreen.mainScreen.bounds.size.width : UIScreen.mainScreen.bounds.size.height)

#import "ATPTGNativeExpressViewController.h"
#import <AnyThinkNative/AnyThinkNative.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@interface ATPTGNativeExpressViewController ()<ATNativeADDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<ATNativeADView *> *ads;
@property(nonatomic,strong)UISwitch *renderSwitch;
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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"是否开启自渲染";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    [label sizeToFit];
    label.frame = CGRectMake(20, 100, label.bounds.size.width, label.bounds.size.height);
    
    UISwitch *renderSwitch = [[UISwitch alloc] init];
    [self.view addSubview:renderSwitch];
    [renderSwitch sizeToFit];
    renderSwitch.frame = CGRectMake(180, 95, renderSwitch.bounds.size.width, renderSwitch.bounds.size.height);
    self.renderSwitch = renderSwitch;
    
}

- (void)loadAd{
    NSLog(@"%s", __FUNCTION__);
    NSValue *size = [NSValue valueWithCGSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200)];
    NSMutableDictionary *extra = @{
        kATExtraInfoNativeAdSizeKey: size,
        kATExtraInfoRootViewControllerKey: self,
        kATExtraInfoNativeAdTypeKey: @(ATGDTNativeAdTypeTemplate)
    }.mutableCopy;  ///b67b7e8d47ce7f。 //
    
    if (self.renderSwitch.isOn) {
        extra[kATExtraInfoNativeAdTypeKey] =  @(ATGDTNativeAdTypeSelfRendering);
    }
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
    if (self.renderSwitch.isOn) {
        /// 一定实现ATPSelfRenderDelegate协议
        config.renderingViewClass = [ATPTGSelfNativeView class];
    }
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

- (void)didCloseDetailInAdView:(ATNativeADView *)adView
                   placementID:(NSString *)placementID
                         extra:(NSDictionary *)extra {
    NSLog(@"topon信息详情页关闭");
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


@implementation ATPTGSelfNativeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildViews];
        [self layoutChildViews];
    }
    return self;
}

- (void)renderAd:(PTGNativeExpressAd *)ad {
    [ad darwUnregisterView];
    self.titleLabel.text = ad.title;
    self.bodyLabel.text = ad.body;
    PTGMediaInfo *info = ad.imageUrls.firstObject;
    NSURL *url = [NSURL URLWithString:info.url];
    [self.iv sd_setImageWithURL:url];
    
    NSLog(@"当前素材宽 = %d 高 = %d",info.width,info.height);
    [ad setContainer:self clickableViews:@[self]];
}


- (void)addChildViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.iv];
    [self addSubview:self.bodyLabel];
    [self addSubview:self.closeButton];
}

- (void)layoutChildViews {
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-8);
        make.width.equalTo(self).offset(-16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
    }];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.right.equalTo(self.titleLabel);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.right.equalTo(self.iv);
    }];
}



- (void)closeButtonDidClicked {
    if ([self.delegate respondsToSelector:@selector(trackNativeAdClosed)]) {
        [self.delegate trackNativeAdClosed];
    }
}

- (UIImageView *)iv {
    if(!_iv) {
        _iv = [UIImageView new];
        _iv.layer.masksToBounds = true;
        _iv.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iv;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bodyLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end



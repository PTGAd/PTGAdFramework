//
//  PTGNativeExpessViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeCountViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderCell.h"

@interface PTGNativeCountViewController ()<PTGNativeExpressAdDelegate,UITableViewDelegate,UITableViewDataSource,PTGSplashAdDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)UIButton *loadButton;
@property(nonatomic,strong)UIButton *loadButton1;
@property(nonatomic,strong)UIButton *loadButton2;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray<PTGNativeExpressAd *> *ads;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIView *redView;

@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation PTGNativeCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize size = CGSizeMake(self.view.bounds.size.width, self.type == PTGNativeExpressAdTypeSelfRender ? 80 : 200);
    NSString *placementId = self.type == PTGNativeExpressAdTypeSelfRender ?  @"900002888" : @"900003374";
    _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                 type:self.type
                                                               adSize:size];
    _manager.delegate = self;
    _manager.currentViewController = self;
    self.ads = @[];
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [self addChildViewsAndLayout];
//    
//    NSString *placementId = @"900000397";
//    _splashAd = [[PTGSplashAd alloc] initWithPlacementId:placementId];
//    _splashAd.delegate = self;
//    [_splashAd loadAd];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.loadButton1];
    [self.view addSubview:self.loadButton2];
    [self.tableView addSubview:self.redView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    [self.loadButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [self.loadButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-160);
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.redView addGestureRecognizer:pan];
    [self.redView setHidden:true];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取手势在视图中的偏移量
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    // 更新视图位置
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
    pan.view.center = center;
    
    // 重置手势的偏移量，避免累加效果
    [pan setTranslation:CGPointZero inView:pan.view.superview];
}

#pragma mark - action -
- (void)buttonClicked:(UIButton *)sender {
    for (int i = 0; i < 25; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *queueName = [NSString stringWithFormat:@"com.example.concurrentQueue%d", i % 20];
            dispatch_queue_t queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                [self.manager loadAd];
            });
        });
    }
}

- (void)buttonClicked1:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 100; i++) {
        NSString *queueName = [NSString stringWithFormat:@"com.example.concurrentQueue%d", i % 20];
        dispatch_queue_t queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            [weakSelf.manager loadAd];
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:true];
    });
}

- (void)buttonClicked2:(UIButton *)sender {
    [self.manager loadAd];
}


#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ads.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = self.ads[indexPath.row];
    
    PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
    BOOL isSelfRender = self.manager.type == PTGNativeExpressAdTypeSelfRender;
    NSString *identifier = isSelfRender ? NSStringFromClass(PTGFeedRenderCell.class) : NSStringFromClass(UITableViewCell.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (isSelfRender) {
        PTGFeedRenderCell *renderCell = (PTGFeedRenderCell *)cell;
        [renderCell renderAd:ad];
        renderCell.delegate = self;
       
    } else {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [[cell.contentView viewWithTag:12345] removeFromSuperview];
        ad.nativeExpressAdView.tag = 12345;
        [cell.contentView addSubview:ad.nativeExpressAdView];
    }
    return cell;
}


#pragma  mark - PTGFeedRenderCellDelegate -
- (void)renderAdView:(PTGFeedRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    NSMutableArray *arrM = self.ads.mutableCopy;
    [arrM containsObject:ad] ? [arrM removeObject:ad] : nil;
    self.ads = arrM.copy;
    [self.tableView reloadData];
    NSLog(@"信息流广告将要被关闭");

}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == PTGNativeExpressAdTypeSelfRender) {
        return 200;
    }
    return self.ads[indexPath.row].nativeExpressAdView.frame.size.height;
}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    [ads enumerateObjectsUsingBlock:^(__kindof PTGNativeExpressAd * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"信息流广告价格，%ld",obj.price);
        [obj render];
        [obj setController:self];
    }];
    NSMutableArray *arrM = self.ads.mutableCopy;
    [arrM addObjectsFromArray:ads];
    self.ads = arrM.copy;
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"信息流广告加载失败，%@",error);
}

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告渲染成功，%@",nativeExpressAd);
    
    
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (!nativeExpressAd.isReady) {
        NSMutableArray *ads = [self.ads mutableCopy];
        [ads removeObject:nativeExpressAd];
        self.ads = ads;
    }
    [self.tableView reloadData];
}

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"ad = %@",nativeExpressAd);
    NSLog(@"信息流广告渲染失败，%@",error);
    NSMutableArray *arrM = self.ads.mutableCopy;
    [arrM removeObject:nativeExpressAd];
    self.ads = arrM.copy;
    [self.tableView reloadData];
}

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告曝光");
}

/// 广告显示失败，广告资源过期（媒体缓存广告，广告展示时，广告资源已过期）
/// @param nativeExpressAd 展示失败的广告
/// 展示失败后，请移除广告，如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"信息流广告曝光失败 error = %@",error);
}

/// 原生模板将被点击了
/// @param nativeExpressAd  被点击的模板广告
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告被点击");
}

///  原生模板广告被关闭了
/// @param nativeExpressAd 要关闭的模板广告
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    NSMutableArray *arrM = self.ads.mutableCopy;
    [arrM containsObject:nativeExpressAd] ? [arrM removeObject:nativeExpressAd] : nil;
    self.ads = arrM.copy;
    [self.tableView reloadData];
    NSLog(@"信息流广告将要被关闭");
}

/// 原生模板广告将要展示详情页
/// @param nativeExpressAd  广告
- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告展示详情页");
}

/// 原生模板广告将要关闭详情页
/// @param nativeExpressAd 广告
- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告详情页被关闭");
}


#pragma mark - get -
- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setTitle:@"间隔50毫秒，异步请求100次" forState:UIControlStateNormal];
        [_loadButton setBackgroundColor:UIColor.lightGrayColor];
        _loadButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (UIButton *)loadButton1 {
    if (!_loadButton1) {
        _loadButton1= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton1 setTitle:@"同时请求100次，500毫秒后，销毁" forState:UIControlStateNormal];
        [_loadButton1 setBackgroundColor:UIColor.lightGrayColor];
        _loadButton1.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton1 addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton1;
}

- (UIButton *)loadButton2 {
    if (!_loadButton2) {
        _loadButton2= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton2 setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton2 setBackgroundColor:UIColor.lightGrayColor];
        _loadButton2.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton2 addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton2;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        [_tableView registerClass:PTGFeedRenderCell.class forCellReuseIdentifier:NSStringFromClass(PTGFeedRenderCell.class)];
    }
    return _tableView;
}

- (UIView *)redView {
    if (!_redView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 300)];
        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"拖动视图移动";
        _redView = label;
        _redView.userInteractionEnabled = true;
    }
    return _redView;
}

- (void)dealloc {
    [self.redView removeFromSuperview];
}

#pragma mark - PTGSplashAdDelegate -
/// 开屏加载成功
- (void)ptg_splashAdDidLoad:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (splashAd.isReady) {
        [splashAd showAdWithViewController:self];
    }
    [self.manager loadAd];
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

///  开屏广告将要展示
- (void)ptg_splashAdWillVisible:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告%s",__func__);
}

- (void)ptg_splashAdDetailDidClose:(PTGSplashAd *)splashAd {
    NSLog(@"开屏广告详情页关闭%s",__func__);
}
@end

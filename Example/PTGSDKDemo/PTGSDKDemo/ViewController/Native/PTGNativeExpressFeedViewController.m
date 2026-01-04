//
//  PTGNativeExpressFeedViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeExpressFeedViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderCell.h"
#import <MJRefresh/MJRefresh.h>
#import "PTGTableViewHeader.h"

@implementation PTGTableView

- (void)dealloc {
    NSLog(@"释放了 %s",__func__);
}

@end

@interface PTGNativeExpressFeedViewController ()<PTGNativeExpressAdDelegate,UITableViewDelegate,UITableViewDataSource,PTGSplashAdDelegate>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)PTGTableView *tableView;
@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)PTGSplashAd *splashAd;
@property(nonatomic,strong)NSTimer *timer;

// 数据相关属性
@property(nonatomic,strong)NSMutableArray *dataArray; // 普通数据数组
@property(nonatomic,assign)NSInteger pageSize; // 每页数据条数
@property(nonatomic,assign)NSInteger currentPage; // 当前页码

@property(nonatomic,strong)PTGTableViewHeader *headerView;

@property(nonatomic,strong)UIView *maskView;

@end

@implementation PTGNativeExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.dataArray = [NSMutableArray array];
    self.pageSize = 20; // 默认每页5条数据
    self.currentPage = 1;
    [self addChildViewsAndLayout];
    [self setupRefresh];
    [self loadData]; // 加载初始数据
//    self.maskView.hidden = YES;
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.maskView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    PTGTableViewHeader *headerView = [[PTGTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    headerView.viewController = self;
    [headerView loadAd];
    self.tableView.tableHeaderView = headerView;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.maskView addGestureRecognizer:pan];
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
- (void)buttonClicked2:(UIButton *)sender {
    [self.manager loadAd];
}

#pragma mark - 数据加载 -
- (void)setupRefresh {
    // 导入头文件 #import <MJRefresh/MJRefresh.h>
    __weak typeof(self) weakSelf = self;
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重置页码和数据
        weakSelf.currentPage = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf loadData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 页码加1
        weakSelf.currentPage++;
        [weakSelf loadData];
    }];
}

- (void)loadData {
    [self.manager loadAd];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//        
//        // 添加到数据源
//        [self.dataArray addObjectsFromArray:pageData];
//        
//        // 结束刷新

//        
//    });
}


#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    
    if ([data isKindOfClass:PTGNativeExpressAd.class]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        BOOL isSelfRender = ad.isNativeExpress == NO;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DataCell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = [self getDataWithIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:PTGFeedRenderCell.class]) {
        return;
    }
    [self.navigationController pushViewController:PTGNativeExpressFeedViewController.new animated:YES];
}

#pragma  mark - PTGFeedRenderCellDelegate -
- (void)renderAdView:(PTGFeedRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    [self.dataArray containsObject:ad] ? [self.dataArray removeObject:ad] : nil;
    [self.tableView reloadData];
    NSLog(@"信息流广告将要被关闭");

}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    if ([data isKindOfClass:PTGNativeExpressAd.class]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        if (ad.isNativeExpress) {
            return ad.nativeExpressAdView.frame.size.height;
        }
        return 200;
    }
    return 40;
}

- (NSObject *)getDataWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        return self.dataArray[indexPath.row];
    }
    return nil;
}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    
    PTGNativeExpressAd *ad = ads.firstObject;
    NSLog(@"信息流广告素材 = %@",ads.firstObject.adMaterial);
    [ad render];
    [ad setController:self];
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页-第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:item];
    }
    [pageData insertObject:ad atIndex:2];
    NSInteger oldCount = self.dataArray.count;
    [self.dataArray addObjectsFromArray:pageData];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i < pageData.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:oldCount + i inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

/// 原生模版广告获取失败
/// @param manager 广告管理类
/// @param error 错误信息
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"信息流广告加载失败，%@",error);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/// 原生模版渲染成功
/// @param nativeExpressAd 渲染成功的模板广告
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告渲染成功，%@",nativeExpressAd);
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (!nativeExpressAd.isReady) {
        NSMutableArray *dataArray = [self.dataArray mutableCopy];
        [dataArray removeObject:nativeExpressAd];
        self.dataArray = dataArray;
    }
    [self.tableView reloadData];
}

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"ad = %@",nativeExpressAd);
    NSLog(@"信息流广告渲染失败，%@",error);
    [self.dataArray removeObject:nativeExpressAd];
    [self.tableView reloadData];
}

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"@@@@信息流广告曝光");
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
    [self.dataArray containsObject:nativeExpressAd] ? [self.dataArray removeObject:nativeExpressAd] : nil;
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
- (PTGNativeExpressAdManager *)manager {
    if (!_manager) { //  457 900000231
        CGSize size = CGSizeMake(self.view.bounds.size.width, self.type == PTGNativeExpressAdTypeSelfRender ? 80 : 200);
         NSString *placementId = self.type == PTGNativeExpressAdTypeSelfRender ?  @"900004714" : @"900003374";
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                     type:self.type
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}

- (PTGTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PTGTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        [_tableView registerClass:PTGFeedRenderCell.class forCellReuseIdentifier:NSStringFromClass(PTGFeedRenderCell.class)];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"DataCell"];
    }
    return _tableView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 500)];
        _maskView.backgroundColor = UIColor.redColor;
        _maskView.hidden = YES;
    }
    return _maskView;
}


- (void)dealloc {

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

//
//  PTGVideoControlDemoViewController.m
//  PTGSDKDemo
//
//  Created by AI Assistant on 2024/12/19.
//  视频播放控制Demo - 演示在cell展示时播放视频，消失时暂停视频
//

#import "PTGVideoControlDemoViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderCell.h"
#import <MJRefresh/MJRefresh.h>

@interface PTGVideoControlDemoViewController () <PTGNativeExpressAdDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PTGNativeExpressAdManager *manager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray; // 普通数据数组
@property (nonatomic, assign) NSInteger pageSize; // 每页数据条数
@property (nonatomic, assign) NSInteger currentPage; // 当前页码

// 视频播放控制相关
@property (nonatomic, strong) NSMutableSet<PTGFeedRenderCell *> *visibleVideoAds; // 当前可见的视频广告
@property (nonatomic, strong) PTGNativeExpressAd *currentPlayingAd; // 当前正在播放的广告

@end

@implementation PTGVideoControlDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频播放控制Demo";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 初始化数据
    self.dataArray = [NSMutableArray array];
    self.visibleVideoAds = [NSMutableSet set];
    self.pageSize = 20;
    self.currentPage = 1;
    
    [self setupUI];
    [self setupRefresh];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 页面显示时延迟检查视频播放状态，确保tableView已经完成布局
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleVideoPlaybackForVisibleCells];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 页面即将消失时暂停所有视频
    [self pauseAllVideos];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupRefresh {
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        // 重置页码和数据
        strongSelf.currentPage = 1;
        [strongSelf.dataArray removeAllObjects];
        [strongSelf.visibleVideoAds removeAllObjects];
        strongSelf.currentPlayingAd = nil;
        [strongSelf loadData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        strongSelf.currentPage++;
        [strongSelf loadData];
    }];
}

- (void)loadData {
    [self.manager loadAd];
}

#pragma mark - Video Control Methods

- (void)pauseAllVideos {
    for (PTGFeedRenderCell *cell in self.visibleVideoAds) {
        if ([cell.ad isVideoAd]) {
            [cell pauseVideo];
            NSLog(@"暂停视频广告: %@", cell.ad);
        }
    }
    self.currentPlayingAd = nil;
}

- (void)handleVideoPlaybackForVisibleCells {
    // 获取当前可见的cell
    NSArray<UITableViewCell *> *visibleCells = self.tableView.visibleCells;
    NSMutableSet<PTGFeedRenderCell *> *currentVisibleAds = [NSMutableSet set];
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:PTGFeedRenderCell.class] && [self isCellVisibleOverThreshold:obj inTableView:self.tableView threshold:0.5]) {
            [currentVisibleAds addObject:(PTGFeedRenderCell *)obj];
        }
    }];
    
    // 暂停不再可见的视频
    NSMutableSet<PTGFeedRenderCell *> *adsToStop = [self.visibleVideoAds mutableCopy];
    [adsToStop minusSet:currentVisibleAds];
    for (PTGFeedRenderCell *cell in adsToStop) {
        [cell pauseVideo];
        if (self.currentPlayingAd == cell.ad) {
            self.currentPlayingAd = nil;
        }
    }
    // 更新可见广告集合
    self.visibleVideoAds = currentVisibleAds;
    
    NSArray<PTGFeedRenderCell *> *sortedViews = [currentVisibleAds.allObjects sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        CGFloat y1 = CGRectGetMinY(view1.frame);
        CGFloat y2 = CGRectGetMinY(view2.frame);
        
        if (y1 < y2) {
            return NSOrderedAscending;
        } else if (y1 > y2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];

    if (sortedViews.count > 0 && !self.currentPlayingAd) {
        // 找到最靠近屏幕中心的视频广告
        PTGFeedRenderCell *cell = sortedViews.firstObject;
        if (cell) {
            [cell playVideo];
            self.currentPlayingAd = cell.ad;
            NSLog(@"视频广告可见，开始播放: %@", cell);
        }
    }
}

- (BOOL)isCellVisibleOverThreshold:(UITableViewCell *)cell inTableView:(UITableView *)tableView threshold:(CGFloat)threshold {
    // 1. 将 cell 的 frame 转换为 window 坐标系
    UIWindow *window = tableView.window;
    if (!window) return NO;

    CGRect cellRectInWindow = [cell convertRect:cell.bounds toView:window];
    CGRect windowBounds = window.bounds;

    // 2. 计算系统 UI 遮挡区域（状态栏 + 导航栏）
    CGFloat topSafeArea = 0;
    if (@available(iOS 11.0, *)) {
        topSafeArea = window.safeAreaInsets.top;
    } else {
        topSafeArea = 20.0; // 状态栏高度
    }

    // 构造“可视区域” = window 去除顶部系统 UI 区域
    CGRect visibleScreenRect = CGRectMake(0, topSafeArea,
                                          windowBounds.size.width,
                                          windowBounds.size.height - topSafeArea);

    // 3. 计算 cell 在可视区域内的交集
    CGRect intersection = CGRectIntersection(cellRectInWindow, visibleScreenRect);
    if (CGRectIsNull(intersection) || CGRectIsEmpty(intersection)) return NO;

    CGFloat cellArea = cell.bounds.size.width * cell.bounds.size.height;
    CGFloat visibleArea = intersection.size.width * intersection.size.height;

    // 4. 判断是否超过阈值（例如 50%）
    return (visibleArea / cellArea) > threshold;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    
    if ([data isKindOfClass:[PTGNativeExpressAd class]]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        BOOL isSelfRender = self.manager.type == PTGNativeExpressAdTypeSelfRender;
        NSString *identifier = isSelfRender ? NSStringFromClass([PTGFeedRenderCell class]) : NSStringFromClass([UITableViewCell class]);
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        if (isSelfRender) {
            PTGFeedRenderCell *renderCell = (PTGFeedRenderCell *)cell;
            [renderCell renderAd:ad];
        } else {
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *oldAdView = [cell.contentView viewWithTag:12345];
            if (oldAdView) {
                [oldAdView removeFromSuperview];
            }
            [cell.contentView addSubview:ad.nativeExpressAdView];
            ad.nativeExpressAdView.tag = 12345;
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DataCell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = (NSString *)data;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    if ([data isKindOfClass:[PTGNativeExpressAd class]]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        if (ad.isNativeExpress) {
            return ad.nativeExpressAdView.frame.size.height;
        }
        return 200;
    }
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 滚动时检查视频播放状态
    [self handleVideoPlaybackForVisibleCells];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 滚动结束时再次检查
    [self handleVideoPlaybackForVisibleCells];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 如果不会继续减速，立即检查
        [self handleVideoPlaybackForVisibleCells];
    }
}

- (NSObject *)getDataWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        return self.dataArray[indexPath.row];
    }
    return nil;
}

#pragma mark - PTGNativeExpressAdDelegate

/// 原生模版广告获取成功
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"视频控制Demo - 信息流广告获取成功，%@", ads);
    
    PTGNativeExpressAd *ad = ads.firstObject;
    [ad render];
    [ad setController:self];
    
    // 生成模拟数据
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页-第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:item];
    }
    
    // 在第3个位置插入广告
    if (pageData.count > 2) {
        [pageData insertObject:ad atIndex:2];
    } else {
        [pageData addObject:ad];
    }
    
    [self.dataArray addObjectsFromArray:pageData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/// 原生模版广告获取失败
- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"视频控制Demo - 信息流广告加载失败，%@", error);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/// 原生模版渲染成功
- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"视频控制Demo - 信息流广告渲染成功，%@", nativeExpressAd);
    
    if ([nativeExpressAd isVideoAd]) {
        NSLog(@"检测到视频广告，类型: %@", [nativeExpressAd isVideoAd] ? @"视频" : @"非视频");
    }
    
    /// 广告是否有效（展示前请务必判断）
    if (!nativeExpressAd.isReady) {
        NSMutableArray *dataArray = [self.dataArray mutableCopy];
        [dataArray removeObject:nativeExpressAd];
        self.dataArray = dataArray;
    }
    
    [self.tableView reloadData];
    
    // 渲染成功后不立即播放视频，等待用户滚动或cell真正可见时再播放
    // 视频播放控制将由scrollViewDidScroll等方法触发
}

/// 原生模版渲染失败
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"视频控制Demo - 信息流广告渲染失败，%@", error);
    [self.dataArray removeObject:nativeExpressAd];
    [self.tableView reloadData];
}

/// 原生模板将要显示
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"视频控制Demo - 信息流广告曝光");
}

/// 广告显示失败
- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"视频控制Demo - 信息流广告曝光失败 error = %@", error);
}

/// 原生模板将被点击了
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"视频控制Demo - 信息流广告被点击");
}

/// 原生模板广告被关闭了
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    [self.dataArray removeObject:nativeExpressAd];
    [self.visibleVideoAds removeObject:nativeExpressAd];
    if (self.currentPlayingAd == nativeExpressAd) {
        self.currentPlayingAd = nil;
    }
    [self.tableView reloadData];
    NSLog(@"视频控制Demo - 信息流广告将要被关闭");
}

/// 原生模板广告将要展示详情页
- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"视频控制Demo - 信息流广告展示详情页");
}

/// 原生模板广告将要关闭详情页
- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"视频控制Demo - 信息流广告详情页被关闭");
    // 详情页关闭后重新检查视频播放状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleVideoPlaybackForVisibleCells];
    });
}

#pragma mark - Getters

- (PTGNativeExpressAdManager *)manager {
    if (!_manager) {
        CGSize size = CGSizeMake(self.view.bounds.size.width, self.type == PTGNativeExpressAdTypeSelfRender ? 80 : 200);
        NSString *placementId = self.type == PTGNativeExpressAdTypeSelfRender ? @"900002888" : @"900003437";
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                     type:self.type
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[PTGFeedRenderCell class] forCellReuseIdentifier:NSStringFromClass([PTGFeedRenderCell class])];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DataCell"];
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"PTGVideoControlDemoViewController dealloc");
}

@end

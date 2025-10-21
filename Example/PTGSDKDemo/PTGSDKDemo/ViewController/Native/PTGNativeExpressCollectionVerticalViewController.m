//
//  PTGNativeExpressCollectionVerticalViewController.m
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2025/01/02.
//

#import "PTGNativeExpressCollectionVerticalViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGCollectionRenderCell.h"
#import <MJRefresh/MJRefresh.h>

// 垂直流式布局
@interface PTGVerticalFlowLayout : UICollectionViewFlowLayout
@end

@implementation PTGVerticalFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    }
    return self;
}

@end

// 垂直CollectionViewCell - 用于显示普通文本内容
@interface PTGVerticalTextCell : UICollectionViewCell
- (void)configureWithText:(NSString *)text;
@end

@implementation PTGVerticalTextCell {
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.numberOfLines = 0;
    [self.contentView addSubview:_textLabel];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
}

- (void)configureWithText:(NSString *)text {
    _textLabel.text = text;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _textLabel.text = nil;
}

@end

@interface PTGNativeExpressCollectionVerticalViewController ()<PTGNativeExpressAdDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PTGCollectionRenderCellDelegate>

@property(nonatomic, strong) PTGNativeExpressAdManager *manager;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) PTGVerticalFlowLayout *flowLayout;

// 数据相关属性
@property(nonatomic, strong) NSMutableArray *dataArray; // 普通数据数组
@property(nonatomic, assign) NSInteger pageSize; // 每页数据条数
@property(nonatomic, assign) NSInteger currentPage; // 当前页码

@end

@implementation PTGNativeExpressCollectionVerticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"垂直滚动广告测试";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.dataArray = [NSMutableArray array];
    self.pageSize = 20;
    self.currentPage = 1;
    [self addChildViewsAndLayout];
    [self setupRefresh];
    [self loadData];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupRefresh {
    __weak typeof(self) weakSelf = self;
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf loadData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
    // 上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf loadData];
    }];
}

- (void)loadData {
    [self.manager loadAd];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    
    if ([data isKindOfClass:PTGNativeExpressAd.class]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        if (ad.isNativeExpress) {
            PTGVerticalTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGVerticalTextCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            [[cell.contentView viewWithTag:12345] removeFromSuperview];
            ad.nativeExpressAdView.tag = 12345;
            [cell.contentView addSubview:ad.nativeExpressAdView];
            return cell;
        } else {
            PTGCollectionRenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGCollectionRenderCell" forIndexPath:indexPath];
            PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
            [[cell.contentView viewWithTag:12345] removeFromSuperview];
            cell.delegate = self;
            [cell renderAd:ad];
            return cell;
        }
    } else {
        PTGVerticalTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGVerticalTextCell" forIndexPath:indexPath];
        [cell configureWithText:(NSString *)data];
        [[cell.contentView viewWithTag:12345] removeFromSuperview];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld个item", (long)indexPath.item);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *data = [self getDataWithIndexPath:indexPath];
    CGFloat width = CGRectGetWidth(collectionView.bounds) - 30; // 减去左右边距
    
    if ([data isKindOfClass:PTGNativeExpressAd.class]) {
        PTGNativeExpressAd *ad = (PTGNativeExpressAd *)data;
        if (ad.isNativeExpress) {
            // 模板广告使用返回的模板视图高度
            CGFloat adHeight = ad.nativeExpressAdView.frame.size.height;
            return CGSizeMake(width, adHeight > 0 ? adHeight : 200);
        }
        // 自渲染广告使用固定高度
        return CGSizeMake(width, 200);
    }
    
    // 普通文本内容使用随机高度
    CGFloat height = 200 + arc4random_uniform(301); // 200-500随机高度
    return CGSizeMake(width, height);
}

#pragma mark - PTGNativeExpressAdDelegate

- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"垂直滚动广告获取成功，%@", ads);
    
    PTGNativeExpressAd *ad = ads.firstObject;
    [ad render];
    [ad setController:self];
    
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页-第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:item];
    }
    
    // 在第5个位置插入广告
    if (pageData.count > 4) {
        [pageData insertObject:ad atIndex:4];
    }
    
    [self.dataArray addObjectsFromArray:pageData];
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"垂直滚动广告加载失败，%@", error);
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"垂直滚动广告渲染成功，%@", nativeExpressAd);
    /// 广告是否有效（展示前请务必判断）
    /// 如不严格按照此方法对接，将导致因曝光延迟时间造成的双方消耗gap过大，请开发人员谨慎对接
    if (!nativeExpressAd.isReady) {
        NSMutableArray *dataArray = [self.dataArray mutableCopy];
        [dataArray removeObject:nativeExpressAd];
        self.dataArray = dataArray;
    }
    // 模板广告渲染成功后需要刷新布局，因为高度可能已经改变
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"垂直滚动广告渲染失败，%@", error);
    [self.dataArray removeObject:nativeExpressAd];
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"垂直滚动广告曝光");
}

- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"垂直滚动广告曝光失败 error = %@", error);
}

- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"垂直滚动广告被点击");
}

- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    [self.dataArray removeObject:nativeExpressAd];
    [self.collectionView reloadData];
    NSLog(@"垂直滚动广告将要被关闭");
}

- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"垂直滚动广告展示详情页");
}

- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"垂直滚动广告详情页被关闭");
}

#pragma mark - PTGCollectionRenderCellDelegate

- (void)renderAdView:(PTGCollectionRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    [self.dataArray removeObject:ad];
    [self.collectionView reloadData];
    NSLog(@"垂直滚动广告被手动关闭");
}

#pragma mark - Private Methods

- (NSObject *)getDataWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.dataArray.count) {
        return self.dataArray[indexPath.item];
    }
    return nil;
}

#pragma mark - Getters

- (PTGNativeExpressAdManager *)manager {
    if (!_manager) {
        // 计算实际的item宽度，考虑CollectionView的布局边距
        CGFloat itemWidth = CGRectGetWidth(self.view.bounds) - 30; // 减去左右边距15*2
        CGSize size = CGSizeMake(itemWidth, self.type == PTGNativeExpressAdTypeSelfRender ? 80 : 200);
        NSString *placementId = self.type == PTGNativeExpressAdTypeSelfRender ? @"900002888" : @"900003437";
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:placementId
                                                                     type:self.type
                                                                   adSize:size];
        _manager.delegate = self;
        _manager.currentViewController = self;
    }
    return _manager;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[PTGVerticalFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[PTGCollectionRenderCell class] forCellWithReuseIdentifier:@"PTGCollectionRenderCell"];
        [_collectionView registerClass:[PTGVerticalTextCell class] forCellWithReuseIdentifier:@"PTGVerticalTextCell"];
    }
    return _collectionView;
}

- (void)dealloc {
    NSLog(@"PTGNativeExpressCollectionVerticalViewController dealloc");
}

@end

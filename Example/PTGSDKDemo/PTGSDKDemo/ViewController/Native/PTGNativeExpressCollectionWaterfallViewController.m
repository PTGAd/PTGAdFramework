//
//  PTGNativeExpressCollectionWaterfallViewController.m
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2025/01/02.
//

#import "PTGNativeExpressCollectionWaterfallViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGFeedRenderCell.h"
#import <MJRefresh/MJRefresh.h>
#import "PTGCollectionRenderCell.h"
@class PTGWaterfallFlowLayout;


@implementation PTGWaterfallModel

- (instancetype)initWithData:(NSObject *)data {
    self = [super init];
    if (self) {
        if ([data isKindOfClass:PTGNativeExpressAd.class]) {
            self.ad = (PTGNativeExpressAd *)data;
        } else {
            self.title = (NSString *)data;
           
        }
    }
    return self;
}

- (CGFloat)height {
    if (_height > 0) {
        return _height;
    }
    if (self.ad && self.ad.isNativeExpress) {
        _height = self.ad.nativeExpressAdView.bounds.size.height;
    } else {
        _height = 200 + arc4random_uniform(301);
    }
    return _height;
}

@end

// 瀑布流布局协议
@protocol PTGWaterfallFlowLayoutDelegate <NSObject>
- (CGFloat)waterfallFlowLayout:(PTGWaterfallFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@end

// 瀑布流布局
@interface PTGWaterfallFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) NSInteger columnCount; // 列数
@property (nonatomic, assign) CGFloat columnSpacing; // 列间距
@property (nonatomic, assign) CGFloat rowSpacing; // 行间距
@property (nonatomic, assign) UIEdgeInsets sectionInsets; // 内边距
@property (nonatomic, weak) id<PTGWaterfallFlowLayoutDelegate> delegate; // 代理
@end

@implementation PTGWaterfallFlowLayout {
    NSMutableArray *_attributesArray;
    NSMutableArray *_columnHeights;
}

- (instancetype)init {
    if (self = [super init]) {
        _columnCount = 2;
        _columnSpacing = 10;
        _rowSpacing = 10;
        _sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    _attributesArray = [NSMutableArray array];
    _columnHeights = [NSMutableArray array];
    
    // 初始化列高度
    for (NSInteger i = 0; i < _columnCount; i++) {
        [_columnHeights addObject:@(_sectionInsets.top)];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributesArray addObject:attributes];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
    CGFloat itemWidth = (collectionViewWidth - _sectionInsets.left - _sectionInsets.right - (_columnCount - 1) * _columnSpacing) / _columnCount;
    
    // 找到最短的列
    NSInteger shortestColumn = 0;
    CGFloat shortestHeight = [_columnHeights[0] floatValue];
    for (NSInteger i = 1; i < _columnCount; i++) {
        CGFloat height = [_columnHeights[i] floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            shortestColumn = i;
        }
    }
    
    CGFloat itemHeight = [self itemHeightAtIndexPath:indexPath itemWidth:itemWidth];
    CGFloat x = _sectionInsets.left + shortestColumn * (itemWidth + _columnSpacing);
    CGFloat y = shortestHeight;
    
    attributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
    
    // 更新列高度
    _columnHeights[shortestColumn] = @(y + itemHeight + _rowSpacing);
    
    return attributes;
}

- (CGFloat)itemHeightAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    // 通过delegate获取item高度
    if (self.delegate && [self.delegate respondsToSelector:@selector(waterfallFlowLayout:heightForItemAtIndexPath:itemWidth:)]) {
        return [self.delegate waterfallFlowLayout:self heightForItemAtIndexPath:indexPath itemWidth:itemWidth];
    }
    return 0;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visibleAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _attributesArray) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [visibleAttributes addObject:attributes];
        }
    }
    return visibleAttributes;
}

- (CGSize)collectionViewContentSize {
    CGFloat maxHeight = 0;
    for (NSNumber *height in _columnHeights) {
        maxHeight = MAX(maxHeight, [height floatValue]);
    }
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), maxHeight + _sectionInsets.bottom);
}

@end

// 瀑布流文本Cell - 用于显示普通文本内容
@interface PTGWaterfallTextCell : UICollectionViewCell
- (void)configureWithText:(NSString *)text;
@end

@implementation PTGWaterfallTextCell {
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
    _textLabel.font = [UIFont systemFontOfSize:14];
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



@interface PTGNativeExpressCollectionWaterfallViewController ()<PTGNativeExpressAdDelegate, UICollectionViewDataSource, UICollectionViewDelegate, PTGWaterfallFlowLayoutDelegate, PTGCollectionRenderCellDelegate>

@property(nonatomic, strong) PTGNativeExpressAdManager *manager;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) PTGWaterfallFlowLayout *flowLayout;

// 数据相关属性
@property(nonatomic, strong) NSMutableArray<PTGWaterfallModel *> *dataArray; // 普通数据数组
@property(nonatomic, assign) NSInteger pageSize; // 每页数据条数
@property(nonatomic, assign) NSInteger currentPage; // 当前页码

@end

@implementation PTGNativeExpressCollectionWaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瀑布流广告测试";
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
    PTGWaterfallModel *data = [self getDataWithIndexPath:indexPath];
    
    if (data.ad) {
        if (data.ad.isNativeExpress) {
            PTGWaterfallTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGWaterfallTextCell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            [[cell.contentView viewWithTag:12345] removeFromSuperview];
            data.ad.nativeExpressAdView.tag = 12345;
            [cell.contentView addSubview:data.ad.nativeExpressAdView];
            return cell;
        } else {
            PTGCollectionRenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGCollectionRenderCell" forIndexPath:indexPath];
            [[cell.contentView viewWithTag:12345] removeFromSuperview];
            PTGNativeExpressAd *ad = data.ad;
            cell.delegate = self;
            [cell renderAd:ad];
            return cell;
        }
        
    } else {
        PTGWaterfallTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGWaterfallTextCell" forIndexPath:indexPath];
        [cell configureWithText:data.title];
        [[cell.contentView viewWithTag:12345] removeFromSuperview];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld个item", (long)indexPath.item);
}

#pragma mark - PTGNativeExpressAdDelegate

- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"瀑布流广告获取成功，%@", ads);
    
    PTGNativeExpressAd *ad = ads.firstObject;
    [ad render];
    [ad setController:self];
    
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页-第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:[[PTGWaterfallModel alloc] initWithData:item]];
    }
    
    // 在第3个位置插入广告
    if (pageData.count > 2) {
        [pageData insertObject:[[PTGWaterfallModel alloc] initWithData:ad] atIndex:2];
    }
    
    [self.dataArray addObjectsFromArray:pageData];
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"瀑布流广告加载失败，%@", error);
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"瀑布流广告渲染成功，%@", nativeExpressAd);
    if (!nativeExpressAd.isReady) {
        NSArray<PTGWaterfallModel *> *tempArray = [[self dataArray] copy];
        [tempArray enumerateObjectsUsingBlock:^(PTGWaterfallModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.ad == nativeExpressAd) {
                [self.dataArray removeObject:obj];
                *stop = YES;
            }
        }];
    }
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"瀑布流广告渲染失败，%@", error);
    NSArray<PTGWaterfallModel *> *tempArray = [[self dataArray] copy];
    [tempArray enumerateObjectsUsingBlock:^(PTGWaterfallModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.ad == nativeExpressAd) {
            [self.dataArray removeObject:obj];
            *stop = YES;
        }
    }];
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"瀑布流广告曝光");
}

- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"瀑布流广告曝光失败 error = %@", error);
}

- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"瀑布流广告被点击");
}

- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    NSArray<PTGWaterfallModel *> *tempArray = [[self dataArray] copy];
    [tempArray enumerateObjectsUsingBlock:^(PTGWaterfallModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.ad == nativeExpressAd) {
            [self.dataArray removeObject:obj];
            *stop = YES;
        }
    }];
    [self.collectionView reloadData];
    NSLog(@"瀑布流广告将要被关闭");
}

- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"瀑布流广告展示详情页");
}

- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"瀑布流广告详情页被关闭");
}

#pragma mark - PTGCollectionRenderCellDelegate

- (void)renderAdView:(PTGCollectionRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    NSArray<PTGWaterfallModel *> *tempArray = [[self dataArray] copy];
    [tempArray enumerateObjectsUsingBlock:^(PTGWaterfallModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.ad == ad) {
            [self.dataArray removeObject:obj];
            *stop = YES;
        }
    }];
    [self.collectionView reloadData];
    NSLog(@"瀑布流广告被手动关闭");
}

#pragma mark - PTGWaterfallFlowLayoutDelegate

- (CGFloat)waterfallFlowLayout:(PTGWaterfallFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    PTGWaterfallModel *data = [self getDataWithIndexPath:indexPath];
    return data.height;
    
}

#pragma mark - Private Methods

- (PTGWaterfallModel *)getDataWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.dataArray.count) {
        return self.dataArray[indexPath.item];
    }
    return nil;
}

#pragma mark - Getters

- (PTGNativeExpressAdManager *)manager {
    if (!_manager) {
        CGSize size = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 30) / 2.0, self.type == PTGNativeExpressAdTypeSelfRender ? 80 : 200);
        NSString *placementId = self.type == PTGNativeExpressAdTypeSelfRender ? @"900004714" : @"900004471";
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
        _flowLayout = [[PTGWaterfallFlowLayout alloc] init];
        _flowLayout.delegate = self;
        _flowLayout.columnCount = 2;
        _flowLayout.columnSpacing = 10;
        _flowLayout.rowSpacing = 10;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[PTGCollectionRenderCell class] forCellWithReuseIdentifier:@"PTGCollectionRenderCell"];
        [_collectionView registerClass:[PTGWaterfallTextCell class] forCellWithReuseIdentifier:@"PTGWaterfallTextCell"];
    }
    return _collectionView;
}

- (void)dealloc {
    NSLog(@"PTGNativeExpressCollectionWaterfallViewController dealloc");
}

@end

//
//  PTGNativeExpressCollectionHorizontalViewController.m
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2025/01/02.
//

#import <UIKit/UIKit.h>
#import "PTGNativeExpressCollectionHorizontalViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>
#import "PTGCollectionRenderCell.h"
#import <MJRefresh/MJRefresh.h>

// 水平流式布局
@interface PTGHorizontalFlowLayout : UICollectionViewFlowLayout
@end

@implementation PTGHorizontalFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 15;
        self.minimumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    }
    return self;
}

- (CGSize)itemSize {
    CGFloat height = CGRectGetHeight(self.collectionView.bounds) - self.sectionInset.top - self.sectionInset.bottom;
    return CGSizeMake(250, height); // 固定宽度
}

@end

// 水平CollectionViewCell - 用于显示普通文本内容
@interface PTGHorizontalTextCell : UICollectionViewCell
- (void)configureWithText:(NSString *)text;
@end

@implementation PTGHorizontalTextCell {
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
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.numberOfLines = 0;
    [self.contentView addSubview:_textLabel];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(12, 12, 12, 12));
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

@interface PTGNativeExpressCollectionHorizontalViewController ()<PTGNativeExpressAdDelegate, UICollectionViewDataSource, UICollectionViewDelegate, PTGCollectionRenderCellDelegate>

@property(nonatomic, strong) PTGNativeExpressAdManager *manager;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) PTGHorizontalFlowLayout *flowLayout;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *loadMoreButton;

// 数据相关属性
@property(nonatomic, strong) NSMutableArray *dataArray; // 普通数据数组
@property(nonatomic, assign) NSInteger pageSize; // 每页数据条数
@property(nonatomic, assign) NSInteger currentPage; // 当前页码

@end

@implementation PTGNativeExpressCollectionHorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"水平滚动广告测试";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.dataArray = [NSMutableArray array];
    self.pageSize = 10;
    self.currentPage = 1;
    [self addChildViewsAndLayout];
    [self loadData];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.loadMoreButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.height.mas_equalTo(30);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    [self.loadMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(44);
    }];
}

- (void)loadData {
    [self.manager loadAd];
}

- (void)loadMoreButtonTapped {
    self.currentPage++;
    [self loadData];
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
            PTGHorizontalTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGHorizontalTextCell" forIndexPath:indexPath];
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
        PTGHorizontalTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PTGHorizontalTextCell" forIndexPath:indexPath];
        [cell configureWithText:(NSString *)data];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld个item", (long)indexPath.item);
}

#pragma mark - PTGNativeExpressAdDelegate

- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"水平滚动广告获取成功，%@", ads);
    
    PTGNativeExpressAd *ad = ads.firstObject;
    [ad render];
    [ad setController:self];
    
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页\n第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:item];
    }
    
    // 在第3个位置插入广告
    if (pageData.count > 2) {
        [pageData insertObject:ad atIndex:2];
    }
    
    [self.dataArray addObjectsFromArray:pageData];
    [self.collectionView reloadData];
    
    // 滚动到新加载的内容
    if (self.currentPage > 1 && self.dataArray.count > self.pageSize) {
        NSInteger targetIndex = (self.currentPage - 1) * self.pageSize;
        if (targetIndex < self.dataArray.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:targetIndex inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }
    }
}

- (void)ptg_nativeExpressAdFailToLoad:(PTGNativeExpressAdManager *)manager error:(NSError *_Nullable)error {
    NSLog(@"水平滚动广告加载失败，%@", error);
    
    // 即使广告加载失败，也加载普通数据
    NSMutableArray *pageData = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageSize; i++) {
        NSString *item = [NSString stringWithFormat:@"第%ld页\n第%ld条数据", (long)self.currentPage, (long)i+1];
        [pageData addObject:item];
    }
    
    [self.dataArray addObjectsFromArray:pageData];
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdRenderSuccess:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"水平滚动广告渲染成功，%@", nativeExpressAd);
    if (!nativeExpressAd.isReady) {
        NSMutableArray *dataArray = [self.dataArray mutableCopy];
        [dataArray removeObject:nativeExpressAd];
        self.dataArray = dataArray;
    }
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"水平滚动广告渲染失败，%@", error);
    [self.dataArray removeObject:nativeExpressAd];
    [self.collectionView reloadData];
}

- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"水平滚动广告曝光");
}

- (void)ptg_nativeExpressAdShowFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"水平滚动广告曝光失败 error = %@", error);
}

- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"水平滚动广告被点击");
}

- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
    [self.dataArray removeObject:nativeExpressAd];
    [self.collectionView reloadData];
    NSLog(@"水平滚动广告将要被关闭");
}

- (void)ptg_nativeExpressAdWillPresentScreen:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"水平滚动广告展示详情页");
}

- (void)ptg_nativeExpressAdVDidCloseOtherController:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"水平滚动广告详情页被关闭");
}

#pragma mark - PTGCollectionRenderCellDelegate

- (void)renderAdView:(PTGCollectionRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad {
    [self.dataArray removeObject:ad];
    [self.collectionView reloadData];
    NSLog(@"水平滚动广告被手动关闭");
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
        CGSize size = CGSizeMake(250, self.type == PTGNativeExpressAdTypeSelfRender ? 120 : 280);
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
        _flowLayout = [[PTGHorizontalFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[PTGCollectionRenderCell class] forCellWithReuseIdentifier:@"PTGCollectionRenderCell"];
        [_collectionView registerClass:[PTGHorizontalTextCell class] forCellWithReuseIdentifier:@"PTGHorizontalTextCell"];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"水平滚动广告展示";
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        _loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
        [_loadMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loadMoreButton.backgroundColor = [UIColor systemBlueColor];
        _loadMoreButton.layer.cornerRadius = 22;
        _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loadMoreButton addTarget:self action:@selector(loadMoreButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadMoreButton;
}

- (void)dealloc {
    NSLog(@"PTGNativeExpressCollectionHorizontalViewController dealloc");
}

@end

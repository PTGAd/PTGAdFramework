//
//  PTGNativeExpessViewController.m
//  PTGSDKDemo
//
//  Created by admin on 2021/2/7.
//

#import "PTGNativeExpressDrawViewController.h"
#import <Masonry/Masonry.h>
#import <PTGAdSDK/PTGAdSDK.h>

@interface PTGCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)PTGNativeExpressAd *ad;

@end

@implementation PTGCollectionViewCell

- (void)displayAd:(PTGNativeExpressAd *)ad {
    self.ad = ad;
    [ad displayAdToView:self.contentView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.ad darwUnregisterView];
}

@end

@interface PTGNativeExpressDrawViewController ()<PTGNativeExpressAdDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)PTGNativeExpressAdManager *manager;
@property(nonatomic,strong)UIButton *loadButton;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray<PTGNativeExpressAd *> *ads;

@end

@implementation PTGNativeExpressDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.hidden = YES;
    [self addChildViewsAndLayout];
}

- (void)addChildViewsAndLayout {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.loadButton];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
}

#pragma mark - action -
- (void)buttonClicked:(UIButton *)sender {
    [self.manager loadAd];
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ads.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PTGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(PTGCollectionViewCell.class) forIndexPath:indexPath];
    PTGNativeExpressAd *ad = self.ads[indexPath.item];
    [cell displayAd:ad];
    return cell;
}

#pragma mark - PTGNativeExpressAdDelegate -
/// 原生模版广告获取成功
/// @param manager 广告管理类
/// @param ads 广告数组 一般只会有一条广告数据 使用数组预留扩展
- (void)ptg_nativeExpressAdSuccessToLoad:(PTGNativeExpressAdManager *)manager ads:(NSArray<__kindof PTGNativeExpressAd *> *)ads {
    NSLog(@"信息流广告获取成功，%@",ads);
    [ads enumerateObjectsUsingBlock:^(__kindof PTGNativeExpressAd * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj render];
        [obj setController:self];
    }];
    NSMutableArray *arrM = self.ads ? self.ads.mutableCopy : [NSMutableArray new];
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
    [self.collectionView reloadData];
}

/// 原生模版渲染失败
/// @param nativeExpressAd 渲染失败的模板广告
/// @param error 渲染过程中的错误
- (void)ptg_nativeExpressAdRenderFail:(PTGNativeExpressAd *)nativeExpressAd error:(NSError *_Nullable)error {
    NSLog(@"信息流广告渲染失败，%@",error);
    NSMutableArray *arrM = self.ads.mutableCopy;
    [arrM containsObject:nativeExpressAd] ? [arrM removeObject:nativeExpressAd] : nil;
    [self.collectionView reloadData];
}

/// 原生模板将要显示
/// @param nativeExpressAd 要显示的模板广告
- (void)ptg_nativeExpressAdWillShow:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告曝光");
}

/// 原生模板将被点击了
/// @param nativeExpressAd  被点击的模板广告
- (void)ptg_nativeExpressAdDidClick:(PTGNativeExpressAd *)nativeExpressAd {
    NSLog(@"信息流广告被点击");
}

///  原生模板广告被关闭了
/// @param nativeExpressAd 要关闭的模板广告
- (void)ptg_nativeExpressAdViewClosed:(PTGNativeExpressAd *)nativeExpressAd {
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
    if (!_manager) {
        _manager = [[PTGNativeExpressAdManager alloc] initWithPlacementId:@"900000401" type:PTGNativeExpressAdTypeDraw adSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
        _manager.delegate = self;
    }
    return _manager;
}

- (UIButton *)loadButton {
    if (!_loadButton) {
        _loadButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setTitle:@"加载广告" forState:UIControlStateNormal];
        [_loadButton setBackgroundColor:UIColor.lightGrayColor];
        _loadButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.view.bounds.size;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:PTGCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(PTGCollectionViewCell.class)];
    }
    return _collectionView;
}

@end




//
//  PTGNativeExpressCollectionWaterfallViewController.h
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2025/01/02.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGWaterfallModel: NSObject

@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)PTGNativeExpressAd *ad;
@property(nonatomic,strong)NSString *title;

- (instancetype)initWithData:(NSObject *)data;

@end

/**
 * 原生广告瀑布流CollectionView测试控制器
 * 支持自渲染和模板广告
 */
@interface PTGNativeExpressCollectionWaterfallViewController : UIViewController

@property(nonatomic,assign)PTGNativeExpressAdType type;

@end

NS_ASSUME_NONNULL_END

//
//  PTGNativeExpressCollectionHorizontalViewController.h
//  PTGSDKDemo
//
//  Created by taoyongjiu on 2025/01/02.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 水平滚动CollectionView原生广告测试控制器
 * 支持自渲染和模板广告
 */
@interface PTGNativeExpressCollectionHorizontalViewController : UIViewController

/**
 * 广告类型
 */
@property (nonatomic, assign) PTGNativeExpressAdType type;

@end

NS_ASSUME_NONNULL_END
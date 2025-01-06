//
//  PTGNativeAdView.h
//  PTGAdSDK
//
//  Created by admin on 2021/2/22.
//

#import <UIKit/UIKit.h>
#import "PTGNativeAdViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTGNativeAdView : UIView

/// 广告id
@property(nonatomic,copy,readonly)NSString *placementId;

@property(nonatomic,strong)UIViewController *viewController;

/// 设置title文字大小
@property(nonatomic,assign)CGFloat titleSize;
/// 设置title文字颜色
@property(nonatomic,strong)UIColor *titleColor;
/// 视图背景色
@property(nonatomic,strong)UIColor *bgColor;
/// 文字链广告的滚动速度
@property(nonatomic,assign)CGFloat animationSpeed;
/// 此属性用于修改广告视图位置
@property(nonatomic,assign)CGPoint origin;

@property(nonatomic,weak)id<PTGNativeAdViewDelegate> delegate;

- (void)render;

@end

NS_ASSUME_NONNULL_END

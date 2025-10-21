//
//  PTGCollectionRenderCell.h
//  PTGSDKDemo
//
//  Created by AI Assistant on 2024/12/19.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>
NS_ASSUME_NONNULL_BEGIN

@class PTGCollectionRenderCell;

/// 由媒体实现自渲染广告的 点击关闭 
@protocol PTGCollectionRenderCellDelegate <NSObject>

- (void)renderAdView:(PTGCollectionRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad;

@end

@interface PTGCollectionRenderCell : UICollectionViewCell

- (void)renderAd:(PTGNativeExpressAd *)ad;

@property(nonatomic,weak) id<PTGCollectionRenderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
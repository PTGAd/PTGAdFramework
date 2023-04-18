//
//  PTGFeedRenderCell.h
//  PTGSDKDemo
//
//  Created by 陶永久 on 2022/11/7.
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>
NS_ASSUME_NONNULL_BEGIN

@class PTGFeedRenderCell;

/// 由媒体实现自渲染广告的 点击关闭 
@protocol PTGFeedRenderCellDelegate <NSObject>

- (void)renderAdView:(PTGFeedRenderCell *)cell clickClose:(PTGNativeExpressAd *)ad;

@end

@interface PTGFeedRenderCell : UITableViewCell

@property(nonatomic,strong)PTGNativeExpressAd *ad;

@property(nonatomic,weak) id<PTGFeedRenderCellDelegate> delegate;

@property(nonatomic,strong,readonly)UIView *adView;

@end

NS_ASSUME_NONNULL_END

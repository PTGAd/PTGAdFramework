//
//  FTAdBidProtocol.h
//  OneAdSDK
//
//  Created by huankuai on 2024/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FTAdBidLossReason)
{
    FTAdBidLossLowPrice          = 1, //价格竞败
    FTAdBidLossFloorPrice        = 2, //底价过滤
    FTAdBidLossTimeout           = 3, //广告超时返回
    FTAdBidLossFrequencyControl  = 4, //广告频控
    FTAdBidLossOther             = 5, //其他原因
};

@protocol FTAdBidProtocol <NSObject>
/// 竞价胜出调用
/// - Parameter price: 媒体竞价方第二名的价格, 单位：分/ecpm
- (void)sendWinPrice:(int)price;

/// 竞价失败调用
/// - Parameters:
///   - price: 媒体竞价的最高价, 单位：分/ecpm
///   - reason: 竞价失败的原因，详见 FTAdBidLossReason
- (void)sendLossPrice:(int)price reason:(FTAdBidLossReason)reason;
@end

NS_ASSUME_NONNULL_END

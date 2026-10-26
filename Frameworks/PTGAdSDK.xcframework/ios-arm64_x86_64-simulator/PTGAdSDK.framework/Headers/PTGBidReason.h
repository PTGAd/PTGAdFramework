//
//  BidReason.h
//  PTGAdSDK
//
//  Created by yongjiu on 2025/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 比普通常规广告低
    BidLossCodeNormal = 1001,
    /// 比竞价广告低
    BidLossCodeHB = 1002,
    /// 竞价超时 如长时间无竞价结果通知mp sdk
    BidLossCodeTimeout = 1003,
    /// 广告换成过期
    BidLossCodeExpire = 1004,
    /// 其他
    BidLossCodeOther = 1005,
} PTGBidLossCode;

typedef enum : NSInteger {
    PTGADNIDCSJ = 101,        // 穿山甲
    PTGADNIDYLH = 102,        // 优量汇
    PTGADNIDBD = 103,         // 百度
    PTGADNIDKS = 104,         // 快手
    PTGADNIDADMOB = 108,      // AdMob
    PTGADNIDMINTEGRAL = 109,  // Mintegral
    PTGADNIDSIGMOB = 110,     // Sigmob
    PTGADNIDOTHER = -1        // 其他
} PTGADNID;

@interface PTGBidReason : NSObject

/* ==========竞价失败时使用============ */
/// 竞价失败code
@property(nonatomic,assign)PTGBidLossCode lossCode;
/// 当lossCode == BidLossCodeOther时 可以传递自定义的竞价失败原因
@property(nonatomic,copy)NSString *lossOtherReason;
/// 竞胜方价格
@property(nonatomic,assign)double winPrice;
/// 竞胜方渠道id
@property(nonatomic,assign)PTGADNID winAdnId;
/// 额外字段 用于媒体自定义 key value 均为NSString 类型
@property(nonatomic,strong)NSDictionary<NSString *,NSString *> *extra;


@property(nonatomic,strong,readonly)NSDictionary<NSString *,NSString *> *lossParams;


@end

NS_ASSUME_NONNULL_END

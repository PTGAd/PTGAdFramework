//
//  EMAdsProtocol.h
//  EdiMobSDK
//
//  Created by 刘德汉 on 2023/9/25.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EMAdsLossReason) {
    EMAdsLossReasonLowPrice          = 8406,    // 竞败(价格低)
    EMAdsLossReasonNoBid             = 8407,    // 低价过滤
    EMAdsLossReasonPriorityLow       = 8408     // 曝光优先级低
};

@protocol EMAdsProtocol <NSObject>
/**
 *  竞胜之后调用, 需要在调用广告 show 之前调用
 *
 *  @param price 竞胜价格 (单位: 分)，值类型为NSNumber *
 *  @param maxLossPrice 竞败最高价格 (单位: 分)，值类型为NSNumber *
 */
- (void)sendWinPrice:(NSNumber *)price maxLossPrice:(NSNumber *)maxLossPrice;

/**
 *  竞败之后或未参竞调用
 *
 *  winPrice ：竞胜价格 (单位: 分)，值类型为NSNumber *，
 *  winChannel : 竞胜的广告主编号 值类型为NSInteger，
 *  reason ：优量汇广告竞败原因，竞败原因参考枚举MYAdsLossReason中的定义，必填
 *  reason -->
 1：广点通
 2：穿山甲
 3：百青藤
 4：快手联盟
 5：爱奇艺
 6：阿里
 7：VIVO
 8：OPPO
 9：小米
 10：京东
 11：拼多多
 100：其他
 */
- (void)sendLossReason:(EMAdsLossReason)reason winPrice:(NSNumber *)winPrice winChannel:(NSInteger)winChannel;

@end


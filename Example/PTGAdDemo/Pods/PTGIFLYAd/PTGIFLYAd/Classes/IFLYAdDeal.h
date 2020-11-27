//
//  IFLYAdDeal.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2020/8/25.
//  Copyright © 2020 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 订单信息
 */

@interface IFLYAdDeal : NSObject

/**
 * 双方线下确定好的订单id
 */
@property(strong) NSString* id;

/**
 * 双方线下确认好的订单底价(元)
 */
@property(assign) double bidFlool;

@end

NS_ASSUME_NONNULL_END

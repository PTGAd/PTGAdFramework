//
//  TGToponNativeAdTool.h
//  TGIOT
//
//  Created by Darren on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import <AnyThinkNative/AnyThinkNative.h>

NS_ASSUME_NONNULL_BEGIN

@class TGToponNativeModel;

@interface TGToponNativeAdTool : NSObject

/**处理广告内容 - 依据广告的样式，model ，view 等内容信息来进行处理 */
+ (void)handleNativeRenderWithOffer:(ATNativeAdOffer *)offer containerView:(UIView *)containerView nativeSize:(CGSize)nativeSize delegate:(id<ATNativeADDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END

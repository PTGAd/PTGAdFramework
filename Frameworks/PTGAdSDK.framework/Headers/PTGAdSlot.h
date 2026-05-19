//
//  PTGAdSlot.h
//  PTGAdSDK
//
//  Created by yongjiu on 2025/9/4.
//

#import <Foundation/Foundation.h>
#import <PTGAdSDK/PTGRewardedVideoModel.h>

NS_ASSUME_NONNULL_BEGIN


@interface PTGAdSlot : NSObject
/// 广告位ID
@property(nonatomic,copy)NSString *slotId;
/// 广告size，信息流模板 横幅模板必须传递 width 高自适应，开屏，插屏，激励无需传递
@property(nonatomic,assign)CGSize size;
/// 是否是自渲染，只有信息流位置支持
@property(nonatomic,assign)BOOL isSelfRender;
/// 激励视频时传递的rewarded video model. 可传空
@property(nullable,nonatomic,strong)PTGRewardedVideoModel *rewardedVideoModel;

@end

NS_ASSUME_NONNULL_END


//
//  UBiXNativeAdVideoReporter.h
//  PTGAdSDK
//
//  Created by yongjiu on 2025/7/16.
//
#import <Foundation/Foundation.h>

/**
 * 视频事件上报 当媒体使用自定义播放器播放广告视频时，需在对应的监听时上报
 */
@interface PTGNativeAdVideoReporter : NSObject
/// 上报开始播放 (duration:视频长度 秒s)
- (void)reportStartWithDuration:(float)duration;

/// 上报暂停播放 (currentTime:当前播放时长 秒s)
- (void)reportPause:(float)currentTime;

/// 上报继续播放 (currentTime:当前播放时长 秒s)
- (void)reportResume:(float)currentTime;

/// 上报播放进度 (time:已播放时长 秒s)
- (void)reportPlayedTime:(float)time;

/// 上报播放完成
- (void)reportFinish;

/// 上报播放失败及错误信息
- (void)reportFailedWithError:(NSError * __nullable)error;
@end

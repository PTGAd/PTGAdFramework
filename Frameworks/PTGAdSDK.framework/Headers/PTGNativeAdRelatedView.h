//
//  PTGNativeAdRelatedView.h
//  PTGAdSDK
//
//  Created by yongjiu on 2025/7/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGNativeAdVideoReporter.h>

NS_ASSUME_NONNULL_BEGIN
@class PTGNativeAdObject;
@protocol PTGNativeAdVideoViewDelegate <NSObject>

/**
 * 视频开始播放
 */
- (void)ptg_nativeAdVideoViewStartPlay:(UIView *)videoView;

/**
 * 视频暂停播放
 */
- (void)ptg_nativeAdVideoViewPausePlay:(UIView *)videoView;

/**
 * 视频继续播放
 */
- (void)ptg_nativeAdVideoViewResumePlay:(UIView *)videoView;

/**
 * 视频播放进度(秒)
 */
- (void)ptg_nativeAdVideoView:(UIView *)videoView playedTime:(NSInteger)time;

/**
 * 视频播放结束
 * @param error 错误信息
 */
- (void)ptg_nativeAdVideoViewDidPlayFinish:(UIView *)videoView withError:(NSError *)error;

@end

@interface PTGNativeAdRelatedView : NSObject
/**
 * 视频播放器view
 * 遮挡面积不得超过50%，否则影响播放。其子视图不计入遮挡
 * 数据刷新后获取
 */
@property (nonatomic,strong,readonly,nullable)UIView *videoView;
/// 数据刷新后获取
@property (nonatomic, strong, readonly) UIImageView *logoView;
/// 数据刷新后获取  自定义播放器时，使用这个对象上报播放器事件
@property (nonatomic, strong, readonly, nullable) PTGNativeAdVideoReporter *videoReporter;
/// 视频回调
@property (nonatomic, weak) id<PTGNativeAdVideoViewDelegate> videoDelegate;
/// 播放视频广告 外部控制播放器的播放时机
- (void)playVideo;

/// 暂停视频广告 外部控制播放器的暂停时机
- (void)pauseVideo;

@end

NS_ASSUME_NONNULL_END

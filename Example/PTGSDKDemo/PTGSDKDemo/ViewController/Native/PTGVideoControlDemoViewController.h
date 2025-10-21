//
//  PTGVideoControlDemoViewController.h
//  PTGSDKDemo
//
//  Created by AI Assistant on 2024/12/19.
//  视频播放控制Demo - 演示在cell展示时播放视频，消失时暂停视频
//

#import <UIKit/UIKit.h>
#import <PTGAdSDK/PTGAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTGVideoControlDemoViewController : UIViewController

@property(nonatomic, assign) PTGNativeExpressAdType type;

@end

NS_ASSUME_NONNULL_END
//
//  IFLYAdVideoData.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/12/19.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFLYAdVideoData : NSObject

//视频广告链接
@property (readonly,nonatomic,strong) NSString * url;
//视频时长，单位s（非必填）
@property (readonly,nonatomic,strong) NSNumber * duration;
//视频宽度（非必填）
@property (readonly,nonatomic,strong) NSNumber * width;
//视频高度（非必填）
@property (readonly,nonatomic,strong) NSNumber * height;
//视频码率，单位kbps（非必填）
@property (readonly,nonatomic,strong) NSNumber * bitrate;
/**
 * 视频格式（非必填）
 * 0-mp4,1-3gp,2-avi,3-flv
 */
@property (readonly,nonatomic,strong) NSNumber * format;
//缓存时长时间戳，单位s（非必填）
@property (readonly,nonatomic,strong) NSNumber * end_time;
//扩展信息（非必填）
@property (readonly,nonatomic,strong) NSDictionary  * ext;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

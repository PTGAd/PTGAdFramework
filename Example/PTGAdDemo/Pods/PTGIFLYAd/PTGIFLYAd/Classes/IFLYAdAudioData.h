//
//  IFLYAdAudioData.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/12/19.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFLYAdAudioData : NSObject

//音频广告链接
@property (readonly,nonatomic,strong) NSString * url;
//音频时长，单位s（非必填）
@property (readonly,nonatomic,strong) NSNumber * duration;
//音频码率，单位kbps（非必填）
@property (readonly,nonatomic,strong) NSNumber * bitrate;
/**
 * 音频格式（非必填）
 * 0-mp3,1-aac,2-wav
 */
@property (readonly,nonatomic,strong) NSNumber * format;
//缓存时长时间戳，单位s（非必填）
@property (readonly,nonatomic,strong) NSNumber * end_time;
//扩展信息（非必填）
@property (readonly,nonatomic,strong) NSDictionary  * ext;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

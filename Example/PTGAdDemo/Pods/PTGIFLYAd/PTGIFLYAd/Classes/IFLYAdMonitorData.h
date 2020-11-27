//
//  IFLYAdMonitorData.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/12/19.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFLYAdMonitorData : NSObject

@property (readonly,nonatomic,strong) NSArray * impress_urls;
@property (readonly,nonatomic,strong) NSArray * click_urls;
@property (readonly,nonatomic,strong) NSArray * download_start_urls;
@property (readonly,nonatomic,strong) NSArray * download_complete_urls;
@property (readonly,nonatomic,strong) NSArray * install_start_urls;
@property (readonly,nonatomic,strong) NSArray * install_complete_urls;
@property (readonly,nonatomic,strong) NSArray * start_urls;
@property (readonly,nonatomic,strong) NSArray * first_quartile_urls;
@property (readonly,nonatomic,strong) NSArray * mid_point_urls;
@property (readonly,nonatomic,strong) NSArray * third_quartile_urls;
@property (readonly,nonatomic,strong) NSArray * complete_urls;
@property (readonly,nonatomic,strong) NSArray * pause_urls;
@property (readonly,nonatomic,strong) NSArray * resume_urls;
@property (readonly,nonatomic,strong) NSArray * skip_urls;
@property (readonly,nonatomic,strong) NSArray * mute_urls;
@property (readonly,nonatomic,strong) NSArray * unmute_urls;
@property (readonly,nonatomic,strong) NSArray * replay_urls;
@property (readonly,nonatomic,strong) NSArray * close_linear_urls;
@property (readonly,nonatomic,strong) NSArray * fullscreen_urls;
@property (readonly,nonatomic,strong) NSArray * exit_fullscreen_urls;
@property (readonly,nonatomic,strong) NSArray * up_scroll_urls;
@property (readonly,nonatomic,strong) NSArray * down_scroll_urls;
@property (readonly,nonatomic,strong) NSDictionary * ext;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

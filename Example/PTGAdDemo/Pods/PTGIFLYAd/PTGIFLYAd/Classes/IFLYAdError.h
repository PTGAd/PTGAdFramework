//
//  IFLYAdError.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2016/9/26.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IFLYAdErrorCode) {
    //请求成功
    IFLYAdErrorCodeSuccess = 70200,
    
#pragma mark - server
    ////// 70001 ~ 70999 服务端返回错误 //////
    
    //请求成功，但没有广告内容
    IFLYAdErrorCodeNotFill = 70204,
    //无效的广告位ID
    IFLYAdErrorCodeInvalidAdUnitId = 70400,
    //当日广告请求次数达到上限
    IFLYAdErrorCodeOverMaxRequest = 70403,
    //服务端错误
    IFLYAdErrorCodeServer = 70500,
    
#pragma mark - client
    ////// 71001 ~ 71999 SDK定义错误 //////
    
    //未知错误(一般是下发数据解析错误)
    IFLYAdErrorCodeUnknown = 71001,
    //无效的广告请求
    IFLYAdErrorCodeInvalidRequest = 71002,
    //网络错误
    IFLYAdErrorCodeNetWork = 71003,
    //权限未设置
    IFLYAdErrorCodePermission = 71004,
    //广告位id 为空
    IFLYAdErrorCodeEmptyAdUnitId = 71005,
    //超时
    IFLYAdErrorCodeTimeout = 71006,
    //当前视图控制器为nil
    IFLYAdErrorCodeCurrentViewController = 71007,
    //父视图为nil
    IFLYAdErrorCodeFatherView = 71008,
};

@interface IFLYAdError : NSObject

@property (strong,nonatomic) NSString * errorDescription;
@property (assign,nonatomic) int        errorCode;

+ (IFLYAdError *) generateByCode:(int) code;
+ (IFLYAdError *) generateByCode:(int) code description:(NSString *)desc;

@end

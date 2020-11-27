//
//  IFLYAdLog.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2020/4/13.
//  Copyright © 2020 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *调试日志信息
 */
@interface IFLYAdLog : NSObject

/**
 *设置是否开启调试信息
 *
 *设置为YES时，将记录和显示调试日志
 *
 *
 *@param enabled 是否开启调试信息
 */
+ (void)setEnabled:(BOOL)enabled;

@end

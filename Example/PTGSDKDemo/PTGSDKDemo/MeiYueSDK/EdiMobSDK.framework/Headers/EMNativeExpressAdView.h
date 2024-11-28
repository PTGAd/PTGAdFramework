//
//  MYNativeExpressAdView.h
//  MYAdsSDK
//
//  Created by liudehan on 2018/8/13.
//  Copyright © 2018年 King_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMNativeExpressAdView : UIView
/**
 *[必选]
 *原生模板广告渲染,在广告展示时调用,否则会影响收益;
 */
- (void)EM_render;

/**以下方法和属性开发者无需调用和关心*/
/**
 返回广告的eCPM，单位：分
 
 @return 成功返回一个大于等于0的值，-1表示无权限或后台出现异常
 */
- (NSInteger)eCPM;
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, copy) NSString *slotId;
@property (nonatomic, assign) int index;
- (instancetype)initWithFrame:(CGRect)frame style:(id)style ad:(id)ad data:(id)data response:(id)response useOp:(BOOL)useOp;

@end

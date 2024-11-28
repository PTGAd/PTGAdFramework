//
//  MYNativeAdDataObject.h
//  MYAdsSDK
//
//  Created by Eric on 2021/5/4.
//  Copyright © 2021 King_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMNativeAdDataObject : NSObject
/**
 广告标题
 */
@property (nonatomic, copy) NSString *title;

/**
 广告描述
 */
@property (nonatomic, copy) NSString *desc;

/**
 广告大图Url
 */
@property (nonatomic, copy) NSString *imageUrl;

/**
 应用类广告App 图标Url
 */
@property (nonatomic, copy) NSString *iconUrl;

/**
 三小图广告的图片Url集合
 */
@property (nonatomic, copy) NSArray *mediaUrlList;

/**
是否为应用类广告
*/
@property (nonatomic, assign) BOOL isAppAd;

/**
 是否为视频广告
 */
@property (nonatomic, assign) BOOL isVideoAd;

/**
 是否为三小图广告
 */
@property (nonatomic, assign) BOOL isThreeImgsAd;

/**
视频广告播放配置
*/
@property (nonatomic, strong) id videoConfig;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) id data;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL render;

@end

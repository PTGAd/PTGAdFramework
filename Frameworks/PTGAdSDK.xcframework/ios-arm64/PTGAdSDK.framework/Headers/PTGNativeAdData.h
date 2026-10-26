//
//  PTGNativeAdData.h
//  PTGAdSDK
//
//  Created by admin on 2024/1/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PTGAdMaterial;

NS_ASSUME_NONNULL_BEGIN

@interface PTGMediaInfo: NSObject
/// 素材宽
@property (nonatomic, assign, readonly) int width;
/// 素材高
@property (nonatomic, assign, readonly) int height;
/// 图片素材地址
@property (nonatomic, copy, readonly) NSString* url;
/// 视频地址
@property (nonatomic, copy, readonly) NSString *videoUrl;
/// 封面图地址
@property (nonatomic, copy, readonly) NSString *coverImageUrl;
/// 视频时长(s)
@property (nonatomic, assign, readonly) float duration;

@end

@interface PTGNativeAdData : NSObject

/// 标题
@property (nonatomic, copy, readonly) NSString *title;
/// 副标题
@property (nonatomic, copy, readonly) NSString *body;
/// 广告主名称
@property (nonatomic, copy, readonly) NSString *advertiserName;
/// 广告主logo
@property (nonatomic, copy, readonly) NSString *advertiserLogo;
/// icon图片下载链接
@property (nonatomic, copy, readonly) NSString *iconUrl;
/// 点击按钮文案
@property (nonatomic, copy, readonly) NSString *callToAction;
/// App Store评分
@property (nonatomic, assign, readonly) double rating;
/// 素材地址
@property (nonatomic, strong, readonly) NSArray <PTGMediaInfo *> *imageUrls;
/// 视频类素材描述
@property (nonatomic, strong, readonly) PTGMediaInfo *videoAdInfo;
/// 是否响应摇一摇 开屏自渲染使用 用于媒体实现摇一摇UI
@property (nonatomic, assign, readonly) BOOL isShakeAd;

@end

NS_ASSUME_NONNULL_END

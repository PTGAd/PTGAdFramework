//
//  FancyAdModel.h
//  FancyAdSDK
//
//  Created by admin on 2023/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PTGMediaInfo;


@interface PTGAdMaterial : NSObject

/// 素材 id
@property(nonatomic,copy)NSString *materialId;
/// 广告主图
@property(nonatomic,strong)PTGMediaInfo *image;
/// 广告标题  可能为空
@property(nonatomic,copy)NSString *title;
/// 广告描述  可能为空
@property(nonatomic,copy)NSString *desc;
/// 广告主logo
@property(nonatomic,copy)NSString *advertiserLogo;
/// 广告主名称
@property(nonatomic,copy)NSString *advertiserName;

/// 是否是视频广告
@property(nonatomic,assign)BOOL isVideo;
/// 广告图片集合 用于多图信息流
@property(nonatomic,copy)NSArray<PTGMediaInfo *> *images;
@property(nonatomic,strong)PTGMediaInfo *videoAdInfo;
/// 点击按钮文案
@property(nonatomic,copy)NSString *callToAction;
/// icon url
@property(nonatomic,copy)NSString *iconURL;

/// 是否是摇一摇广告 自渲染返回，isShakeAd = YES 时需要开发者自行实现摇一摇UI
@property(nonatomic,assign)BOOL isShakeAd;

@end

NS_ASSUME_NONNULL_END


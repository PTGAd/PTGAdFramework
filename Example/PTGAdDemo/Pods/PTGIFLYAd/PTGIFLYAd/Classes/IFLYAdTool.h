//
//  IFLYAdTool.h
//  IFLYAdLib
//
//  Created by JzProl.m.Qiezi on 2020/4/8.
//  Copyright © 2020 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^IFLYAdToolImageCompletionBlock)(UIImage *image, NSError *error, NSURL *imageURL);

@interface IFLYAdTool : NSObject

#pragma mark - image tools
/**
 * 图片高斯模糊生成新图片
 * 详解：调用此工具类，生成新的高斯模糊的图片，当输入图片的高度小于或等于参数height或传入图片
 *      为nil时返回原图片；否则生成原图片宽度，上下部分高斯模糊原图扩充的图片
 *      @param originImage 原始图片
 *      @param height  新图片高度
 *      @param radius  高斯模糊参数
 */
+ (UIImage*)gaussianBlurImage:(UIImage*)originImage withHeight:(CGFloat)height andRadius:(CGFloat)radius;

/**
 获取指定url的图片(已缓存的)
 
 @param url 图片url地址
 @return 返回图片
 */
+(UIImage*)imageFromURL:(NSString*)url;

/**
 下载指定url的图片
 
 @param url 图片url地址
 @param completionBlock 完成回调
 
 */
+(void)downloadImageFromURL:(NSString*)url completed:(IFLYAdToolImageCompletionBlock)completionBlock;


/**
 下载指定url的图片
 
 @param urls 图片地址NSURL数组
 */
+(void)downloadImagesFromURLs:(NSArray<NSString*>*)urls;

/**
 当前SDK版本号
 */
+(NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END

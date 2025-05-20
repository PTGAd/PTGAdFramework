//
//  UIImage+TGCustomImage.h
//  AncloudCam
//
//  Created by Darren Xia on 2025/5/9.
//  Copyright © 2025 eye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TGCustomImage)

+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size;
+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size colorHexString:(NSString * _Nullable)color;
+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size color:(UIColor * _Nullable)color;

@end

NS_ASSUME_NONNULL_END

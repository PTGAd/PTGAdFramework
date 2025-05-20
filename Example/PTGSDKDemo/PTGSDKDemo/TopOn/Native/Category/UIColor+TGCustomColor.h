//
//  UIColor+TGCustomColor.h
//  AncloudCam
//
//  Created by Darren on 2024/9/10.
//  Copyright © 2024 eye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TGCustomColor)

+ (UIColor *)tg_colorWithColor:(UIColor *)color alpha:(CGFloat)alpha;

+ (UIColor *)tg_colorWithHexString:(NSString *)color;

+ (UIColor *)tg_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END

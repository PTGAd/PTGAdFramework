//
//  UIImage+TGCustomImage.m
//  AncloudCam
//
//  Created by Darren Xia on 2025/5/9.
//  Copyright © 2025 eye. All rights reserved.
//

#import "UIImage+TGCustomImage.h"
#import "UIColor+TGCustomColor.h"

@implementation UIImage (TGCustomImage)

+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size{
    return [self tg_svgImageNamed:imageName size:size colorHexString:nil];
}

+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size colorHexString:(NSString * _Nullable)colorString{
    UIColor *color = nil;
    if (colorString != nil) {
        color = [UIColor tg_colorWithHexString:colorString];
    }
    return [self tg_svgImageNamed:imageName size:size color:color];
}

+ (UIImage *)tg_svgImageNamed:(NSString *)imageName size:(CGSize)size color:(UIColor * _Nullable)color{
    return  nil;
}
//    if (!imageName.length) {
//        return nil;
//    }
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *path = [bundle.bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@.svg",imageName]];
//    SVGKImage *svgImage = [SVGKImage imageWithContentsOfFile:path];
//    if (svgImage == nil) {
//        return nil;
//    }
//    svgImage.size = size;
//    if (color == nil) {
//        return svgImage.UIImage;
//    }
//    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
//    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.UIImage.CGImage);
//    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast || alphaInfo == kCGImageAlphaNoneSkipFirst || alphaInfo == kCGImageAlphaNone;
//    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, svgImage.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextClipToMask(context, rect, svgImage.UIImage.CGImage);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return imageOut;
//}

@end

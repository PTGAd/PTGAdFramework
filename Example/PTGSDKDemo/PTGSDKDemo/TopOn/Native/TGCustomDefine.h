//
//  TGCustomDefine.h
//  AncloudCam
//
//  Created by Darren on 2024/9/10.
//  Copyright © 2024 eye. All rights reserved.
//

#import "TGCustomDefine.h"
#import "UIView+TGExtension.h"
#import "UIColor+TGCustomColor.h"
#import "UIImage+TGCustomImage.h"
#import "NSString+TGCustomString.h"

#ifndef TGCustomDefine_h
#define TGCustomDefine_h

#define TG_ToponAppId           @"a6728476459406"
#define TG_ToponAppKey          @"a9e4701d1dd1b046163f9a713224b34d6"
#define TG_ToponSplashUnitId    @"b672847ed0c1a2"
#define TG_ToponSplashTimeout   5
#define TG_ToponNativeUnitId    @"b6728481ee50a5"
#define TG_OEMBlackColor        [UIColor tg_colorWithHexString:@"#171931"]

#define ROOT_WINDOW ({\
    UIWindow *window = nil;\
    if (@available(iOS 13.0, *)) {\
        window = [[UIApplication sharedApplication].windows firstObject];\
    }else{\
        window = [UIApplication sharedApplication].delegate.window;\
    }\
    window;\
})

#define TG_SCREENWIDTH                      (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define TG_SCREENHEIGHT                     (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

#define TG_RelativeWidthX(value)            (TG_SCREENWIDTH * value / 375.0f)
#define TG_RelativeHeightX(value)           (TG_SCREENHEIGHT * value / 812.0f)

#define TG_NativeAd_Image_Rate              (16.0f / 9)

#define DeviceListBottomNativeAdWidth       (TG_SCREENWIDTH - 2 * TG_RelativeWidthX(20))
#define DeviceListBottomNativeImgWidth      ((DeviceListBottomNativeAdWidth) - 2 * 10)
#define DeviceListBottomNativeAdHeight      (((DeviceListBottomNativeImgWidth) / TG_NativeAd_Image_Rate) + 54 + 46)

#endif /* TGCustomDefine_h */

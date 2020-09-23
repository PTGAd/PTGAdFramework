//
//  PTGMacros.h
//  BUAdSDKDemo
//
//  Created by su on 2020/09/14.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef PTGMacros_h
#define PTGMacros_h

#define express_banner_ID                 @"900546269"
#define express_banner_ID_60090           @"900546269"
#define express_banner_ID_640100          @"900546833"
#define express_banner_ID_600150          @"900546198"
#define express_banner_ID_690388          @"900546673"
#define express_banner_ID_600260          @"900546387"
#define express_banner_ID_600300          @"900546526"
#define express_banner_ID_600400_both     @"945113150"
#define express_banner_ID_600500_both     @"945113147"


#define mainColor PTG_RGB(0xff, 0x63, 0x5c)
#define unValidColor PTG_RGB(0xd7, 0xd7, 0xd7)
#define titleBGColor PTG_RGB(73, 15, 15)
#define selectedColor [UIColor colorWithRed:(73/255.0) green:(15/255.0) blue:(15/255.0) alpha:0.8]
#define PTG_RGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
/// iphone X、XR、XS、XS Max适配
#ifndef PTGMINScreenSide
#define PTGMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef PTGMAXScreenSide
#define PTGMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define PTGiPhoneX ((PTGMAXScreenSide == 812.0) || (PTGMAXScreenSide == 896))
#define NavigationBarHeight (PTGiPhoneX? 88: 64)      // 导航条高度
#define TopMargin        (PTGiPhoneX? 24: 0)
#define BottomMargin     (PTGiPhoneX? 40: 0)      // 状态栏高度

#define PTG_Log(frmt, ...)   \
do {                                                      \
NSLog(@"【BUAdDemo】%@", [NSString stringWithFormat:frmt,##__VA_ARGS__]);  \
} while(0)

#ifndef PTGNativeAdTranslateKey
#define PTGNativeAdTranslateKey @"bu_nativeAd"
#endif


#endif /* PTGMacros_h */

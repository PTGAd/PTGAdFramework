//
//  PTGCommentMacros.h
//  BUAdSDKDemo
//
//  Created by su on 2020/09/14.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#ifndef PTGCommentMacros_h
#define PTGCommentMacros_h

/**
 Get the view with the best results by using the predefined size in pixels.
 When it comes to view display, it is recommended to use the same scaling.
*/
typedef NS_ENUM(NSInteger, PTGProposalSize) {
    PTGProposalSize_Banner600_90,
    PTGProposalSize_Banner640_100,
    PTGProposalSize_Banner600_150,
    PTGProposalSize_Banner600_260,
    PTGProposalSize_Banner600_286,
    PTGProposalSize_Banner600_300,
    PTGProposalSize_Banner690_388,
    PTGProposalSize_Banner600_400,
    PTGProposalSize_Banner600_500,
    PTGProposalSize_Feed228_150,//
    PTGProposalSize_Feed690_388,//
    PTGProposalSize_Interstitial600_400,
    PTGProposalSize_Interstitial600_600,
    PTGProposalSize_Interstitial600_900,
};

#define XReal(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)


#define XH_OverIPhoneX  ([UIScreen mainScreen].bounds.size.height >= 812)
#define XH_ScreenH    [UIScreen mainScreen].bounds.size.height
#define XH_ScreenW    [UIScreen mainScreen].bounds.size.width

/** Progress颜色 */
#define RoundProgressColor  [UIColor whiteColor]
/** 背景色 */
#define BackgroundColor [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.4]
/** 字体颜色 */
#define FontColor  [UIColor whiteColor]

#define SkipTitle  NSLocalizedString(@"跳过",nil)
/** 倒计时单位 */
#define DurationUnit @"S"

#define XH_IPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define XH_IPHONEXR    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define XH_IPHONEXSMAX    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define XH_FULLSCREEN ((XH_IPHONEX || XH_IPHONEXR || XH_IPHONEXSMAX) ? YES : NO)



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
NSLog(@"【PTGAdDemo】%@", [NSString stringWithFormat:frmt,##__VA_ARGS__]);  \
} while(0)

#ifndef PTGNativeAdTranslateKey
#define PTGNativeAdTranslateKey @"bu_nativeAd"
#endif

#endif /* PTGCommentMacros_h */

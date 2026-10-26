//
//  PTGSourceAdType.h
//  Pods
//
//  Created byttt on 2023/1/29.
//

#ifndef PTGSourceAdType_h
#define PTGSourceAdType_h

typedef enum : NSUInteger {
    PTGAdUnknown,           // 未知的广告源
    PTGAdCSJ,               // 穿山甲
    PTGAdGDT,               // 广点通
    PTGAdKS,                // 快手
    PTGAdFancy,             // FancyAPI
    PTGAdJD,                // 京东
    PTGADMY,                // 美约
    PTGAdUbixMerak,         // ubix 自有预算
    PTGAdOneAd
} PTGAdSourceType;


#endif /* PTGSourceAdType_h */

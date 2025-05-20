//
//  TGToponNativeAdTool.m
//  TGIOT
//
//  Created by Darren on 2024/11/28.
//

#import "TGToponNativeAdTool.h"
#import <Masonry/Masonry.h>
#import "TGToponSelfRenderView.h"
#import "TGCustomDefine.h"

typedef NS_ENUM(NSInteger, ATNetworkNativeRenderType) {
    ATNetworkNativeRenderTypeSelfRender = 1,
    ATNetworkNativeRenderTypeSDKRender = 2,
};

@interface NSMutableDictionary (TGToponNativeAdTool)

- (void)TGAd_setDictValue:(id)value key:(NSString *)key;

@end

@implementation NSMutableDictionary (TGToponNativeAdTool)

+ (BOOL)TGAd_isEmpty:(id)object{
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]] && [(NSString *)object isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([object respondsToSelector:@selector(length)]) {
        return [object length] == 0;
    }
    if ([object respondsToSelector:@selector(count)]) {
        return [object count] == 0;
    }
    return NO;
}

+ (NSString *)TGAd_jsonString:(NSDictionary *)dictionary{
    NSError *error;
    NSData *jsonData;
    if (![NSJSONSerialization isValidJSONObject:dictionary]) {
        return @"{}";
    }
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    } @catch (NSException *exception) {
        return @"{}";
    } @finally {}
    if (!jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (void)TGAd_setDictValue:(id)value key:(NSString *)key{
    if ([key isKindOfClass:[NSString class]] == NO) {
        NSAssert(NO, @"key must str");
    }
    if (key != nil && [key respondsToSelector:@selector(length)] && key.length > 0) {
        if ([NSMutableDictionary TGAd_isEmpty:value] == NO) {
            self[key] = value;
        }
//        if (value == nil) {
//            NSAssert(NO, @"value must not equal to nil");
//        }
    } else {
        NSAssert(NO, @"key must not equal to nil");
    }
}

@end

@implementation TGToponNativeAdTool
/**设置 NativeAd 参数样式 赋值对应的解析参数 如果广告平台返回了数据的话 */
+ (NSDictionary *)getNativeAdOfferExtraDic:(ATNativeAdOffer *)offer {
    NSMutableDictionary *extraDic = [NSMutableDictionary dictionary];
    [extraDic TGAd_setDictValue:@(offer.networkFirmID) key:@"networkFirmID"];
    [extraDic TGAd_setDictValue:offer.nativeAd.title key:@"title"];
    [extraDic TGAd_setDictValue:offer.nativeAd.mainText key:@"mainText"];
    [extraDic TGAd_setDictValue:offer.nativeAd.ctaText key:@"ctaText"];
    [extraDic TGAd_setDictValue:offer.nativeAd.advertiser key:@"advertiser"];
    [extraDic TGAd_setDictValue:offer.nativeAd.videoUrl key:@"videoUrl"];
    [extraDic TGAd_setDictValue:offer.nativeAd.logoUrl key:@"logoUrl"];
    [extraDic TGAd_setDictValue:offer.nativeAd.iconUrl key:@"iconUrl"];
    [extraDic TGAd_setDictValue:offer.nativeAd.imageUrl key:@"imageUrl"];
    [extraDic TGAd_setDictValue:offer.nativeAd.imageList key:@"imageList"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.videoDuration) key:@"videoDuration"];
    
    [extraDic TGAd_setDictValue:@(offer.nativeAd.mainImageWidth) key:@"mainImageWidth"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.mainImageHeight) key:@"mainImageHeight"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.videoAspectRatio) key:@"videoAspectRatio"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.nativeExpressAdViewWidth) key:@"nativeExpressAdViewWidth"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.nativeExpressAdViewHeight) key:@"nativeExpressAdViewHeight"];
    
    [extraDic TGAd_setDictValue:@(offer.nativeAd.interactionType) key:@"interactionType"];
    [extraDic TGAd_setDictValue:offer.nativeAd.mediaExt key:@"mediaExt"];
    [extraDic TGAd_setDictValue:offer.nativeAd.source key:@"source"];
    [extraDic TGAd_setDictValue:offer.nativeAd.rating key:@"rating"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.commentNum) key:@"commentNum"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.appSize) key:@"appSize"];
    [extraDic TGAd_setDictValue:offer.nativeAd.appPrice key:@"appPrice"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.isExpressAd) key:@"isExpressAd"];
    [extraDic TGAd_setDictValue:@(offer.nativeAd.isVideoContents) key:@"isVideoContents"];
    [extraDic TGAd_setDictValue:offer.nativeAd.icon key:@"iconImage"];
    [extraDic TGAd_setDictValue:offer.nativeAd.logo key:@"logoImage"];
    [extraDic TGAd_setDictValue:offer.nativeAd.mainImage key:@"mainImage"];
    return extraDic;
}
/**广告的内容offer 信息 */
+ (void)handleNativeRenderWithOffer:(ATNativeAdOffer *)offer containerView:(UIView *)containerView nativeSize:(CGSize)nativeSize delegate:(id<ATNativeADDelegate>)delegate{
    
    NSDictionary *offerExtraDict = [TGToponNativeAdTool getNativeAdOfferExtraDic:offer];
    NSLog(@"TGAdvertManager Native广告素材：%@", offerExtraDict);
    
    CGFloat containerViewWidth = nativeSize.width;
    CGFloat containerViewHeight = nativeSize.height;
    
    CGFloat logoViewWidth = 40;
    CGFloat logoViewHeight = 15;
    // 腾讯
    if (offer.networkFirmID == 8) {
        logoViewWidth = 40;
        logoViewHeight = 15;
    }
    // 百度
    if (offer.networkFirmID == 22) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // 快手
    if (offer.networkFirmID == 28) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // 趣盟
    if (offer.networkFirmID == 74) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // 倍孜
    if (offer.networkFirmID == 101415) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // 章鱼
    if (offer.networkFirmID == 101417) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    
    
    // 瑞狮海外
    if (offer.networkFirmID == 101932) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // Bigo
    if (offer.networkFirmID == 59) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // Mintegral
    if (offer.networkFirmID == 6) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    // Pangle
    if (offer.networkFirmID == 50) {
        logoViewWidth = 15;
        logoViewHeight = 15;
    }
    
    NSString *selfRenderBgColor = @"#F2F8FF";
    
    CGFloat mediaViewLeftX = 10;
    CGFloat mediaViewTopY = 54;
    
    CGFloat mainMediaWidth = containerViewWidth - 2 * 10;
    CGFloat mainMediaHeight = mainMediaWidth / 16.0f * 9;
    
    CGFloat logoLeftX = mediaViewLeftX + 5;
    CGFloat logoTopY = containerViewHeight - 46 - 5 - logoViewHeight;
    
    CGRect mediaViewFrame = CGRectMake(mediaViewLeftX, mediaViewTopY, mainMediaWidth, mainMediaHeight);
    CGRect logoViewFrame = CGRectMake(logoLeftX, logoTopY, logoViewWidth, logoViewHeight);
    
    /**把尺寸，位置参数等赋值给这个类  */
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.delegate = delegate;
    config.sizeToFit = YES;
    config.logoViewFrame = logoViewFrame;
    config.mediaViewFrame = mediaViewFrame;
    config.rootViewController = containerView.tg_viewController;
    config.ADFrame = CGRectMake(0, 0, containerViewWidth, containerViewHeight);
    
    ATNativeADView *nativeAdView = [[ATNativeADView alloc] initWithConfiguration:config currentOffer:offer placementID:TG_ToponNativeUnitId];
    UIView *mediaView = [nativeAdView getMediaView];
    mediaView.clipsToBounds = YES;
    
    TGToponSelfRenderView *selfRenderView = [[TGToponSelfRenderView alloc] initWithOffer:offer config:config];
    selfRenderView.backgroundColor = [UIColor tg_colorWithHexString:selfRenderBgColor];
    
    NSMutableArray * clickAbleViewArray = [NSMutableArray arrayWithObjects:selfRenderView.iconImageView, selfRenderView.titleLabel, selfRenderView.textLabel, selfRenderView.mainImageView, selfRenderView.logoImageView, selfRenderView.advertiserLabel, selfRenderView.ctaLabel, nil];
    
    if (mediaView) {
        [clickAbleViewArray addObject:mediaView];
        selfRenderView.mediaView = mediaView;
        [selfRenderView addSubview:mediaView];
        [mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(selfRenderView.mainImageView);
        }];
    }
    ATNativePrepareInfo *info = [ATNativePrepareInfo loadPrepareInfo:^(ATNativePrepareInfo * _Nonnull prepareInfo) {
        prepareInfo.iconImageView = selfRenderView.iconImageView;
        prepareInfo.titleLabel = selfRenderView.titleLabel;
        prepareInfo.dislikeButton = selfRenderView.dislikeButton;
        prepareInfo.textLabel = selfRenderView.textLabel;
        prepareInfo.mainImageView = selfRenderView.mainImageView;
        prepareInfo.mediaView = selfRenderView.mediaView;
        prepareInfo.logoImageView = selfRenderView.logoImageView;
        prepareInfo.advertiserLabel = selfRenderView.advertiserLabel;
        prepareInfo.ctaLabel = selfRenderView.ctaLabel;
    }];
    
    [nativeAdView registerClickableViewArray:clickAbleViewArray];
    
    [nativeAdView prepareWithNativePrepareInfo:info];
    
    [offer rendererWithConfiguration:config selfRenderView:selfRenderView nativeADView:nativeAdView];
    
    if (offer.nativeAd.isExpressAd) {
        NSLog(@"TGAdvertManager 第三方Native广告是模板广告：%1f，%1f", offer.nativeAd.nativeExpressAdViewWidth, offer.nativeAd.nativeExpressAdViewHeight);;
    } else {
        NSLog(@"TGAdvertManager 第三方Native广告是自渲染广告");
    }
    
    ATNetworkNativeRenderType renderType = [[nativeAdView valueForKey:@"networkNativeRenderType"] intValue];
    if (renderType == ATNetworkNativeRenderTypeSelfRender) {
        NSLog(@"TGAdvertManager Native广告是Topon后台开发者渲染广告");
    } else {
        NSLog(@"TGAdvertManager Native广告是Topon后台Topon模板广告");
    }
    
    NSLog(@"TGAdvertManager Native广告是否为视频广告：%d--%@", offer.nativeAd.isVideoContents, mediaView);
    
    [containerView addSubview:nativeAdView];
    [nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(containerView);
    }];
}

@end

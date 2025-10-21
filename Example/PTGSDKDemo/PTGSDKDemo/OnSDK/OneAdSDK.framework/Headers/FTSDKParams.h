//
//  FantiSDK
//
//  Created by guangkuo.zgk on 2024/11/05.
//  Copyright © 2024 fanti.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTSDKParams : NSObject
/// 媒体iid
@property (nonatomic, copy, nonnull) NSString *mediaId;
/// 应用id
@property (nonatomic, copy, nonnull) NSString *appId;

@property (nonatomic, copy, nullable) NSString *oneid;
@property (nonatomic, copy, nullable) NSString *oneidVersion;
@property (nonatomic, copy, nullable) NSString *lastOneid;
@property (nonatomic, copy, nullable) NSString *lastOneidVersion;

/// 自定义IDFA
@property (nonatomic, copy, nullable) NSString *idfa;
/// 是否禁止使用IDFA。(默认NO),禁用后SDK不再主动获取idfa，外部传入idfa不受影响。
@property (nonatomic, assign) BOOL forbidDeviceId;
/// 是否禁用位置信息。(默认NO)
@property (nonatomic, assign) BOOL forbidLocation;
/// 是否禁用IP信息。(默认NO)
@property (nonatomic, assign) BOOL forbidIPAddress;
/// 是否禁止读取UA。(默认NO)
@property (nonatomic, assign) BOOL forbidUserAgent;
/// 是否禁用个性化广告。(默认NO)
@property (nonatomic, assign) BOOL forbidPersonalizedAds;
/// 是否禁用程序化推荐广告。(默认NO)
@property (nonatomic, assign) BOOL forbidProgrammaticRecommend;
/// 经度
@property (nonatomic, copy, nullable) NSString *longitude;
/// 纬度
@property (nonatomic, copy, nullable) NSString *latitude;

@property (nonatomic, strong, nullable) NSDictionary *extInfo;

@end

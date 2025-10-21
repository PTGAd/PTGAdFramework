//
//  FantiSDK
//
//  Created by guangkuo.zgk on 2024/11/05.
//  Copyright © 2024 fanti.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FTSDKInitState) {
    FTSDKInitStateDefault = 0,
    FTSDKInitStateSuccessed = 1,
    FTSDKInitStateFailed = 2
};


@class FTSDKParams;
@interface FTSDKConfig : NSObject

@property (nonatomic, assign, readonly, class) FTSDKInitState initState;

/**
 * 启动SDK
 */
+ (void)startWithParams:(nullable FTSDKParams *)params;

//查询sdk版本号
+ (nullable NSString *)getSdkVersion;
@end


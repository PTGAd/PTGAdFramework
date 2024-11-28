//
//  TopOnAdManager.m
//  AnyThinkSDKDemo
//
//  Created by Martin Lau on 2020/1/10.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import "TopOnAdManager.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>



@implementation TopOnAdManager
+(instancetype) sharedManager {
    static TopOnAdManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[TopOnAdManager alloc] init];
        
    });
    return sharedManager;
}

-(void) initTopOnSDK {
    

  
    [ATAPI setLogEnabled:YES];
    
    [ATAPI integrationChecking];
    
    //    [ATAPI setHeaderBiddingTestModeWithDeviceID:@"1F7DB84C-5DCF-4095-B059-F18A7D17946C"];
    // set personaliz state
    [[ATAPI sharedInstance] setPersonalizedAdState:ATPersonalizedAdStateType];
    
    // 设置系统平台信息，默认设置IOS=1
    //    ATSystemPlatformTypeIOS = 1,
    //    ATSystemPlatformTypeUnity = 2,
    //    ATSystemPlatformTypeCocos2dx = 3,
    //    ATSystemPlatformTypeCocosCreator = 4,
    //    ATSystemPlatformTypeReactNative = 5,
    //    ATSystemPlatformTypeFlutter = 6,
    //    ATSystemPlatformTypeAdobeAir = 7
    [[ATSDKGlobalSetting sharedManager] setSystemPlatformType:ATSystemPlatformTypeIOS];
    
    // init SDK
    
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//            [[ATAPI sharedInstance] startWithAppID:@"h672833387e858" appKey:@"aca91d52715f8c9175ff91c1b320cd2fc" error:&error];
            NSError *error;
            [[ATAPI sharedInstance] startWithAppID:@"a6728476459406" appKey:@"a9e4701d1dd1b046163f9a713224b34d6" error:&error];
            NSLog(@"error = %@",error);
//            [[ATAPI sharedInstance] startWithAppID:kTopOnAppID appKey:kTopOnAppKey error:nil];
        }];
    } else {
        // Fallback on earlier versions
//        [[ATAPI sharedInstance] startWithAppID:kTopOnAppID appKey:kTopOnAppKey error:nil];
        NSError *error;
        [[ATAPI sharedInstance] startWithAppID:@"a6728476459406" appKey:@"a9e4701d1dd1b046163f9a713224b34d6" error:&error];
        NSLog(@"error = %@",error);
    }
  
}




@end

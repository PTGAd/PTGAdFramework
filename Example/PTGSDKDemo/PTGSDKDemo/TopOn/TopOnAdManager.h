//
//  TopOnAdManager.h
//  AnyThinkSDKDemo
//
//  Created by Martin Lau on 2020/1/10.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopOnAdManager : NSObject
+(instancetype) sharedManager;

-(void) initTopOnSDK;

@end

NS_ASSUME_NONNULL_END

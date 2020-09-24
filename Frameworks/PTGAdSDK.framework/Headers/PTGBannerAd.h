//
//  PTGBannerAd.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/15.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTGAdvertising.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTGBannerAd : PTGAdvertising

- (instancetype)initWithFrame:(CGRect)frame
   placementId:(NSString *)placementId
viewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END

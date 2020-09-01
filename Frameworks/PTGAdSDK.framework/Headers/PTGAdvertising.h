//
//  PTGAdvertising.h
//  PTGAdSDK
//
//  Created by admin on 2020/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PTGAdvertising : NSObject
//
- (void)concurrent:(NSString *)slotId  size :(CGSize)adSize;

- (void)adverDidLoadRefreshfailure;
@end

NS_ASSUME_NONNULL_END

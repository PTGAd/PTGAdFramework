//
//  FTNativeAdObject.h
//  OneAdSDK
//
//  Created by huankuai on 2024/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTAdInfoObject : NSObject

@property (nonatomic, copy) NSString *requestId;
@property (nonatomic, copy) NSString *creativeId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@end

NS_ASSUME_NONNULL_END

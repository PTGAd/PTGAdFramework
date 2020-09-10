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
@property(nonatomic,copy)NSString *placementId;

@property(nonatomic,assign)CGSize adSize;

@property (nonatomic, assign) NSInteger type;//暂时 0 是 开屏 1 信息流 后期改成枚举

- (void)concurrent:(NSString *)slotId  size :(CGSize)adSize;

- (void)adverDidLoadRefreshfailure;
- (void)addMessageToSendQueue;
- (void)clearAdvertising:(id)manger;

@end

NS_ASSUME_NONNULL_END

//
//  ATNativeRenderView.h
//  AnythinkSDKDemo
//
//  Created by Jason on 2021/10/29.
//

#import <AnyThinkNative/AnyThinkNative.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATNativeRenderView : ATNativeADView
@property(nonatomic, readonly) UILabel *textLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UIImageView *mainImageView;
@property(nonatomic, readonly) UIImageView *logoImageView;
@property(nonatomic, readonly) UILabel *advertiserLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;
@property(nonatomic, readonly) UIButton *dislikeButton;

+ (CGFloat)heightWithOffer:(ATNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END

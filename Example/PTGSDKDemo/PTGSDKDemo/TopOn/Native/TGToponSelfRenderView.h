//
//  TGToponSelfRenderView.h
//  TGIOT
//
//  Created by Darren Xia on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "TGNativeDislikeButton.h"
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGToponSelfRenderView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TGNativeDislikeButton *dislikeButton;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIView *mediaView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *advertiserLabel;
@property (nonatomic, strong) UILabel *ctaLabel;

- (instancetype)initWithOffer:(ATNativeAdOffer *)offer config:(ATNativeADConfiguration *)config;

@end

NS_ASSUME_NONNULL_END

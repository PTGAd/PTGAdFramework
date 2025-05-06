//
//  ATNativeRenderView.m
//  AnythinkSDKDemo
//
//  Created by Jason on 2021/10/29.
//

#import "ATNativeRenderView.h"
#import "ATAutoLayout.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@implementation ATNativeRenderView

-(void) initSubviews {
    [super initSubviews];
    _titleLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:18.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
   
    
    _textLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_textLabel];
  
    
    _iconImageView = [UIImageView autolayoutView];
    _iconImageView.layer.cornerRadius = 4.0f;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImageView];
    
    _mainImageView = [UIImageView autolayoutView];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mainImageView];
   
    
    _logoImageView = [UIImageView autolayoutView];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoImageView];
    
    
    _dislikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dislikeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_dislikeButton];
    
    _advertiserLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor lightGrayColor]];
    [self addSubview:_advertiserLabel];
}

- (void)updateAdViewConfiguration:(ATNativeADConfiguration *)configuration currentOffer:(ATNativeAdOffer *)currentOffer placementID:(NSString *)placementID {
    [super updateAdViewConfiguration:configuration currentOffer:currentOffer placementID:placementID];
    _titleLabel.text = self.currentOffer.title;
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:self.currentOffer.imageUrl]];
    _logoImageView.image = self.currentOffer.logo;
    _textLabel.text = self.currentOffer.mainText;
    
    CGFloat h = (UIScreen.mainScreen.bounds.size.width  - 16) * currentOffer.nativeAd.mainImageHeight / currentOffer.nativeAd.mainImageWidth;
    [self.mainImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(h));
    }];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *sdkBundlePath = [mainBundle pathForResource:@"PTGAdSDK" ofType:@"bundle"];
    NSBundle *sdkBundle = [NSBundle bundleWithPath:sdkBundlePath];
    NSString *path = [sdkBundle pathForResource:@"fancy_logo" ofType:@"png"];
    UIImage *logo = [UIImage imageWithContentsOfFile:path];
    self.logoImageView.image = logo;
    
    [self.dislikeButton setImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.currentOffer.iconUrl]];
    self.advertiserLabel.text = self.currentOffer.advertiser;
}

-(void) makeConstraintsForSubviews {
    [super makeConstraintsForSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 42));
        make.top.equalTo(@4);
        make.left.equalTo(@8);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(8);
        make.height.equalTo(@20);
        make.right.equalTo(self.mas_right).offset(-8);
    }];
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(@18);
    }];
    
    [self.mainImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.textLabel.mas_bottom).offset(4);
        make.height.equalTo(@(0));
    }];
    

    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView);
        make.width.equalTo(@42);
        make.height.equalTo(@14);
        make.top.equalTo(self.mainImageView.mas_bottom).offset(3);
    }];
    
    [self.advertiserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageView.mas_right).offset(8);
        make.centerY.equalTo(self.logoImageView);
    }];
    
    [self.dislikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.right.equalTo(self.mainImageView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

+ (CGFloat)heightWithOffer:(ATNativeAd *)nativeAd {
    if (!nativeAd) {
        return 0;
    }
    CGFloat height = (UIScreen.mainScreen.bounds.size.width - 16) * (nativeAd.mainImageHeight / nativeAd.mainImageWidth);
    return 4 + 20 + 4 + 18 + 4 + height + 20;
}


@end

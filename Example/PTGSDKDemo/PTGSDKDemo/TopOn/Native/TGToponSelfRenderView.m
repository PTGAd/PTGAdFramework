//
//  TGToponSelfRenderView.m
//  TGIOT
//
//  Created by Darren Xia on 2025/2/11.
//

#import "TGToponSelfRenderView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "TGCustomDefine.h"
#import "YYCategories/YYCategories.h"

@interface TGToponSelfRenderView()

@property (nonatomic, strong) ATNativeAdOffer *offer;
@property (nonatomic, assign) ATNativeADConfiguration *config;
@property (nonatomic, strong) UIView *ctaBgView;
@property (nonatomic, strong) UIView *titleTextBgView;

@end

@implementation TGToponSelfRenderView

- (void)dealloc {
    NSLog(@"TGAdvertManager TGToponSelfRenderView销毁");
}

- (instancetype)initWithOffer:(ATNativeAdOffer *)offer config:(ATNativeADConfiguration *)config {
    if (self = [super init]) {
        self.offer = offer;
        self.config = config;
        [self createUI];
        [self layoutUI];
        [self setupUI];
    }
    return self;
}

- (void)createUI {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.layer.cornerRadius = 17;
    self.iconImageView.userInteractionEnabled = YES;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageView];
    
    CGSize dislikeImgSize = CGSizeMake(15, 15);
    UIColor *dislikeColor = [UIColor tg_colorWithHexString:@"#8B9FBC"];
    UIImage *dislikeImage = [[UIImage imageNamed:@"closed"] imageByResizeToSize:dislikeImgSize] ;
    NSString *dislikeTitle = @"广告";
    
    self.dislikeButton = [[TGNativeDislikeButton alloc] init];
    self.dislikeButton.titleImgGap = 3;
    self.dislikeButton.layer.cornerRadius = 5;
    self.dislikeButton.titleFont = [UIFont systemFontOfSize:12];
    self.dislikeButton.titleLabel.font = self.dislikeButton.titleFont;
    self.dislikeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 6);
    [self.dislikeButton setImage:dislikeImage forState:UIControlStateNormal];
    [self.dislikeButton setTitle:dislikeTitle forState:UIControlStateNormal];
    [self.dislikeButton setTitleColor:dislikeColor forState:UIControlStateNormal];
    self.dislikeButton.backgroundColor = [UIColor tg_colorWithHexString:@"#DDEDFE"];
    [self addSubview:self.dislikeButton];
    
    self.titleTextBgView = [[UIView alloc] init];
    [self addSubview:self.titleTextBgView];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 2;
    self.textLabel.userInteractionEnabled = YES;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.font = [UIFont systemFontOfSize:14 weight:500];
    self.textLabel.textColor = [UIColor tg_colorWithHexString:@"#171931"];
    [self addSubview:self.textLabel];
    
    self.mainImageView = [[UIImageView alloc] init];
    self.mainImageView.userInteractionEnabled = YES;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.mainImageView];
    
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.userInteractionEnabled = YES;
    self.logoImageView.backgroundColor = [UIColor tg_colorWithHexString:@"#E6F2FF"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.logoImageView];
    
    self.advertiserLabel = [[UILabel alloc] init];
    self.advertiserLabel.userInteractionEnabled = YES;
    self.advertiserLabel.font = [UIFont systemFontOfSize:10];
    self.advertiserLabel.textAlignment = NSTextAlignmentLeft;
    self.advertiserLabel.textColor = [UIColor tg_colorWithHexString:@"#B0B0B0"];
    self.advertiserLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.advertiserLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.userInteractionEnabled = YES;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:12 weight:500];
    self.titleLabel.textColor = [UIColor tg_colorWithHexString:@"#0E1012"];
    [self addSubview:self.titleLabel];
    
    self.ctaBgView = [[UIView alloc] init];
    self.ctaBgView.layer.cornerRadius = 10;
    self.ctaBgView.backgroundColor = [UIColor tg_colorWithHexString:@"#DEEAFF"];
    [self addSubview:self.ctaBgView];
    
    self.ctaLabel = [[UILabel alloc] init];
    self.ctaLabel.userInteractionEnabled = YES;
    self.ctaLabel.font = [UIFont systemFontOfSize:12];
    self.ctaLabel.textAlignment = NSTextAlignmentCenter;
    self.ctaLabel.textColor = [UIColor tg_colorWithHexString:@"#3470FD"];
    [self addSubview:self.ctaLabel];
}

- (void)layoutUI {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.top.mas_equalTo(self.mas_top).mas_offset(10);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(10);
    }];
    
    CGFloat titleImgGap = self.dislikeButton.titleImgGap;
    CGSize dislikeImageSize = self.dislikeButton.currentImage.size;
    UIEdgeInsets edgeInsets = self.dislikeButton.contentEdgeInsets;
    CGSize dislikeSize = [self.dislikeButton.currentTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.dislikeButton.titleFont} context:nil].size;
    CGFloat dislikeButtonWidth = edgeInsets.left + ceil(dislikeSize.width) + titleImgGap + dislikeImageSize.width + edgeInsets.right;
    CGFloat dislikeButtonHeight = ceil(dislikeImageSize.height) + 2 * 6;
    [self.dislikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(dislikeButtonWidth);
        make.height.mas_equalTo(dislikeButtonHeight);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
    }];
    
    BOOL containsIcon = NO;
    if (self.offer.nativeAd.icon) {
        containsIcon = YES;
    } else if (self.offer.nativeAd.iconUrl.length) {
        containsIcon = YES;
    }
    BOOL containsCta = self.offer.nativeAd.ctaText.length > 0;
    [self.titleTextBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_top).mas_offset(27);
        if (containsIcon) {
            make.leading.mas_equalTo(self.iconImageView.mas_trailing).mas_offset(10);
        } else {
            make.leading.mas_equalTo(self.mas_leading).mas_offset(10);
        }
        make.trailing.mas_equalTo(self.dislikeButton.mas_leading).mas_offset(-10);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.leading.trailing.mas_equalTo(self.titleTextBgView);
    }];
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.config.mediaViewFrame.size);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.config.mediaViewFrame.origin.y);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(self.config.mediaViewFrame.origin.x);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.config.logoViewFrame.size);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.config.logoViewFrame.origin.y);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(self.config.logoViewFrame.origin.x);
    }];
    
    [self.advertiserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImageView.mas_centerY);
        make.leading.mas_equalTo(self.logoImageView.mas_trailing).mas_offset(5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).mas_offset(15);
        make.centerY.mas_equalTo(self.mas_bottom).mas_offset(-23);
        if (containsCta) {
            make.trailing.mas_equalTo(self.ctaBgView.mas_leading).mas_offset(-10);
        } else {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(10);
        }
    }];
    
    CGSize ctaSize = [self.offer.nativeAd.ctaText boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.ctaLabel.font} context:nil].size;
    CGFloat ctaBgWidth = ceil(ctaSize.width) + 2 * 10;
    CGFloat ctaBgHeight = 26;
    [self.ctaBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ctaBgWidth);
        make.height.mas_equalTo(ctaBgHeight);
        make.centerY.mas_equalTo(self.mas_bottom).mas_offset(-23);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
    }];
    
    [self.ctaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.ctaBgView.mas_centerX);
        make.centerY.mas_equalTo(self.ctaBgView.mas_centerY);
    }];
}

- (void)setupUI {
    if (self.offer.nativeAd.icon) {
        self.iconImageView.hidden = NO;
        self.iconImageView.image = self.offer.nativeAd.icon;
    } else if (self.offer.nativeAd.iconUrl.length) {
        self.iconImageView.hidden = NO;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.offer.nativeAd.iconUrl]];
    } else {
        self.iconImageView.hidden = YES;
    }
    
    self.textLabel.text = self.offer.nativeAd.mainText;
    self.titleLabel.text = self.offer.nativeAd.title;
    
    if (self.offer.nativeAd.mainImage) {
        self.mainImageView.image = self.offer.nativeAd.mainImage;
    } else {
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.offer.nativeAd.imageUrl]];
    }
    
    if (self.offer.nativeAd.logo) {
        self.logoImageView.hidden = NO;
        self.logoImageView.image = self.offer.nativeAd.logo;
    } else if (self.offer.nativeAd.logoUrl.length) {
        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.offer.nativeAd.logoUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                self.logoImageView.hidden = YES;
            } else {
                self.logoImageView.hidden = NO;
            }
        }];
    } else {
        if (!self.logoImageView.image) {
            self.logoImageView.hidden = YES;
        } else {
            self.logoImageView.hidden = NO;
        }
    }
    
    self.advertiserLabel.text = self.offer.nativeAd.advertiser;
    
    if (self.offer.nativeAd.ctaText.length) {
        self.ctaLabel.hidden = NO;
        self.ctaBgView.hidden = NO;
        self.ctaLabel.text = self.offer.nativeAd.ctaText;
    } else {
        self.ctaLabel.hidden = YES;
        self.ctaBgView.hidden = YES;
        self.ctaLabel.text = nil;
    }
}

@end

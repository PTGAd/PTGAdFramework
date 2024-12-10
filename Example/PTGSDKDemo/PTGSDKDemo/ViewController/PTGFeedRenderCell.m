//
//  PTGFeedRenderCell.m
//  PTGSDKDemo
//
//  Created by 陶永久 on 2022/11/7.
//

#import "PTGFeedRenderCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface PTGFeedRenderCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *bodyLabel;
@property(nonatomic,strong)UIImageView *iv;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)UIView *adView;
@end

@implementation PTGFeedRenderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addChildViews];
        [self layoutChildViews];
    }
    return self;
}

- (void)setAd:(PTGNativeExpressAd *)ad {
    _ad = ad;
    
    self.titleLabel.text = ad.title;
    self.bodyLabel.text = ad.body;
    NSURL *url = [NSURL URLWithString:ad.imageUrls.firstObject];
    [self.iv sd_setImageWithURL:url];
}

- (void)addChildViews {
    [self.contentView addSubview:self.adView];
    [self.adView addSubview:self.titleLabel];
    [self.adView addSubview:self.iv];
    [self.adView addSubview:self.bodyLabel];
    [self.adView addSubview:self.closeButton];
}

- (void)layoutChildViews {
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.adView).offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iv);
        make.left.equalTo(self.iv.mas_right).offset(8);
        make.right.equalTo(self.adView).offset(-8);
    }];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iv);
        make.left.equalTo(self.iv.mas_right).offset(8);
        make.right.equalTo(self.adView).offset(-8);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iv);
        make.right.equalTo(self).offset(-8);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}


- (void)closeButtonDidClicked {
    if ([self.delegate respondsToSelector:@selector(renderAdView:clickClose:)]) {
        [self.delegate renderAdView:self clickClose:self.ad];
    }
}

- (UIImageView *)iv {
    if(!_iv) {
        _iv = [UIImageView new];
        _iv.layer.masksToBounds = true;
        _iv.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iv;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bodyLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"closed"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)adView {
    if (!_adView) {
        _adView = [[UIView alloc] init];
        _adView.backgroundColor = [UIColor clearColor];
    }
    return _adView;
}
@end

//
//  PTGSplashSelfRenderView.m
//  PTGSDKDemo
//
//  Created by yongjiu on 2025/3/5.
//

#import "PTGSplashSelfRenderView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface PTGSplashSelfRenderView()

@property(nonatomic,strong)PTGNativeExpressAd *nativeAd;
@property(nonatomic,strong)UIButton *skipButton;
@property(nonatomic,strong)UIButton *hotAreaButton;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UILabel *shakeLabel;

@end

@implementation PTGSplashSelfRenderView

- (void)updateUI:(PTGNativeExpressAd *)nativeAd {
    self.nativeAd = nativeAd;
    NSString *image = nativeAd.imageUrls.firstObject.url;
    if (image) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
//    self.shakeLabel.hidden = nativeAd.;
    [nativeAd setSplashContainer:self clickableViews:@[self.hotAreaButton]];
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    __block NSInteger time = 5;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        time -= 1;
        if (time > 0) {
            [weakSelf.skipButton setTitle:[NSString stringWithFormat:@"跳过 %ld",(long)time] forState:UIControlStateNormal];
        } else {
            [weakSelf closed];
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildViewsAndLayout];
    }
    return self;
}

- (void)addChildViewsAndLayout {
    [self addSubview:self.imageView];
    [self addSubview:self.skipButton];
    [self addSubview:self.hotAreaButton];
    [self addSubview:self.shakeLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.top.equalTo(@70);
        make.width.equalTo(@54);
        make.height.equalTo(@24);
    }];
    
    [self.hotAreaButton sizeToFit];
    self.hotAreaButton.layer.cornerRadius = self.hotAreaButton.frame.size.height / 2.0;
    [self.hotAreaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-50);
    }];
    
    [self.shakeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.hotAreaButton.mas_top).offset(-20);
    }];
}

- (void)skipAction:(UIButton *)sender {
    [self closed];
}

- (void)closed {
    if ([self.delegate respondsToSelector:@selector(nativeAdViewClosed:)]) {
        [self.delegate nativeAdViewClosed:self.nativeAd];
    }
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"跳过 5" forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _skipButton.layer.cornerRadius = 12;
        _skipButton.layer.masksToBounds = YES;
        _skipButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [_skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (UIButton *)hotAreaButton {
    if (!_hotAreaButton) {
        _hotAreaButton = [UIButton new];
        [_hotAreaButton setTitle:@"点击跳转至详情页或者第三方应用" forState:UIControlStateNormal];
        [_hotAreaButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _hotAreaButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _hotAreaButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _hotAreaButton.layer.borderWidth = 1;
        _hotAreaButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor;
        _hotAreaButton.layer.masksToBounds = true;
        _hotAreaButton.contentEdgeInsets = UIEdgeInsetsMake(18, 32, 18, 32);
    }
    return _hotAreaButton;
}

- (UILabel *)shakeLabel {
    if (!_shakeLabel) {
        _shakeLabel = [UILabel new];
        _shakeLabel.text = @"本次展示摇一摇，媒体自行实现UI展示";
        _shakeLabel.textColor = [UIColor blackColor];
    }
    return _shakeLabel;
}

- (void)dealloc {
    NSLog(@"释放了 %s",__FUNCTION__);
}

@end

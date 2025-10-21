//
//  PTGFeedRenderCell.m
//  PTGSDKDemo
//
//  Created by 陶永久 on 2022/11/7.
//

#import <UIKit/UIKit.h>
#import "PTGFeedRenderView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <objc/message.h>

@interface PTGFeedRenderView()<PTGNativeAdVideoViewDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *bodyLabel;
@property(nonatomic,strong)UIImageView *iv;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)PTGNativeExpressAd *ad;
@property(nonatomic,strong)PTGNativeAdRelatedView *relatedView;

@end

@implementation PTGFeedRenderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildViews];
        [self layoutChildViews];
    }
    return self;
}

- (void)renderAd:(PTGNativeExpressAd *)ad {
    _ad = ad;
    [ad darwUnregisterView];
    self.titleLabel.text = ad.adObject.adData.title;
    self.bodyLabel.text = ad.adObject.adData.body;
    
    self.iv.hidden = ad.isVideoAd;
   
    if (ad.isVideoAd) {
        if (self.relatedView.videoView.superview == self) {
            [self.relatedView.videoView removeFromSuperview];
        }
        self.relatedView = ad.adObject.relatedView;
        [self addSubview:self.relatedView.videoView];
        [self.relatedView.videoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.iv);
        }];
        self.relatedView.videoDelegate = self;
        PTGMediaInfo *info = ad.adObject.adData.videoAdInfo;
        NSLog(@"当前素材宽 = %d 高 = %d",info.width,info.height);
    } else {
        [self.relatedView.videoView removeFromSuperview];
        self.relatedView = nil;
        PTGMediaInfo *info = ad.adObject.adData.imageUrls.firstObject;
        NSLog(@"当前素材宽 = %d 高 = %d",info.width,info.height);
        NSURL *url = [NSURL URLWithString:ad.adObject.adData.imageUrls.firstObject.url];
        [self.iv sd_setImageWithURL:url];
    }
    [self addSubview:self.closeButton];
    [ad.adObject setContainer:self clickableViews:@[self]];
}

- (void)playVideo {
    [self.relatedView playVideo];
}

- (void)pauseVideo {
    [self.relatedView pauseVideo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews frame = %@",[NSValue valueWithCGRect:self.frame]);
}

- (void)addChildViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.iv];
    [self addSubview:self.bodyLabel];
    [self addSubview:self.closeButton];
}

- (void)layoutChildViews {
    
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-8);
        make.width.equalTo(self).offset(-16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
    }];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.right.equalTo(self.titleLabel);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.bottom.right.equalTo(self.iv);
    }];
}



- (void)closeButtonDidClicked {
    if ([self.delegate respondsToSelector:@selector(renderAdView:clickClose:)]) {
        [self.delegate renderAdView:self clickClose:self.ad];
    }
}

#pragma mark - PTGNativeAdVideoViewDelegate -
/**
 * 视频开始播放
 */
- (void)ptg_nativeAdVideoViewStartPlay:(UIView *)videoView {
    NSLog(@"@@@@通知代理视频开始播放 videoView %p",videoView);
}

/**
 * 视频暂停播放
 */
- (void)ptg_nativeAdVideoViewPausePlay:(UIView *)videoView {
    NSLog(@"@@@@通知代理视频暂停播放 videoView %p",videoView);
}

/**
 * 视频继续播放
 */
- (void)ptg_nativeAdVideoViewResumePlay:(UIView *)videoView {
    NSLog(@"@@@@通知代理视频继续播放 videoView %p",videoView);
}

/**
 * 视频播放进度(秒)
 */
- (void)ptg_nativeAdVideoView:(UIView *)videoView playedTime:(NSInteger)time {
    NSLog(@"@@@@通知代理播放进度更新 playedTime = %zd videoView %p",time,videoView);
}

/**
 * 视频播放结束
 * @param error 错误信息
 */
- (void)ptg_nativeAdVideoViewDidPlayFinish:(UIView *)videoView withError:(NSError *)error {
    NSLog(@"@@@@通知代理视频播放结束 videoView %p",videoView);
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
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.font = [UIFont systemFontOfSize:10];
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

- (void)dealloc {
    NSLog(@"释放了1111%s",__func__);
}
@end

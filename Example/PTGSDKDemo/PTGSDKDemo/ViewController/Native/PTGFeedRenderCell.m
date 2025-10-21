//
//  PTGFeedRenderCell.m
//  PTGSDKDemo
//
//  Created by 陶永久 on 2022/11/7.
//

#import "PTGFeedRenderCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <objc/message.h>
#import "PTGFeedRenderView.h"

@interface PTGFeedRenderCell()<PTGFeedRenderViewDelegate>
@property(nonatomic,strong)PTGFeedRenderView *adView;
@property(nonatomic,strong)PTGNativeExpressAd *ad;
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

- (void)playVideo {
    [self.adView playVideo];
}

- (void)pauseVideo {
    [self.adView pauseVideo];
}

- (void)renderAd:(PTGNativeExpressAd *)ad {
    _ad = ad;
    [ad darwUnregisterView];
    [self.adView renderAd:ad];
}


- (void)addChildViews {
    [self.contentView addSubview:self.adView];}

- (void)layoutChildViews {
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


- (void)renderAdView:(PTGFeedRenderView *)view clickClose:(PTGNativeExpressAd *)ad {
    if ([self.delegate respondsToSelector:@selector(renderAdView:clickClose:)]) {
        [self.delegate renderAdView:self clickClose:self.ad];
    }
}

- (PTGFeedRenderView *)adView {
    if (!_adView) {
        _adView = [[PTGFeedRenderView alloc] init];
        _adView.backgroundColor = [UIColor clearColor];
        _adView.delegate = self;
    }
    return _adView;
}
- (void)dealloc {
    NSLog(@"释放了1111%s",__func__);
}
@end

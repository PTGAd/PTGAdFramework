//
//  PTGCollectionRenderCell.m
//  PTGSDKDemo
//
//  Created by AI Assistant on 2024/12/19.
//

#import <UIKit/UIKit.h>
#import "PTGCollectionRenderCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <objc/message.h>
#import "PTGFeedRenderView.h"

@interface PTGCollectionRenderCell()<PTGFeedRenderViewDelegate>
@property(nonatomic,strong)PTGFeedRenderView *adView;
@property(nonatomic,strong)PTGNativeExpressAd *ad;
@end

@implementation PTGCollectionRenderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addChildViews];
        [self layoutChildViews];
    }
    return self;
}

- (void)renderAd:(PTGNativeExpressAd *)ad {
    self.ad = ad;
    [ad darwUnregisterView];
    [self.adView renderAd:ad];
}

- (void)addChildViews {
    [self.contentView addSubview:self.adView];
}

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
        _adView.delegate = self;
    }
    return _adView;
}

- (void)dealloc {
    NSLog(@"释放了1111%s",__func__);
}

@end

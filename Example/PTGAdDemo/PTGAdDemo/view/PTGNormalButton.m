//
//  PTGNormalButton.m
//  PTGAdSDK_Example
//
//  Created by admin on 2020/9/14.
//  Copyright © 2020 yingzhao.fyz. All rights reserved.
//

#import "PTGNormalButton.h"
#import "PTGMacros.h"

#define buttonHeight 40
#define leftEdge 30

@implementation PTGNormalButton
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(leftEdge, frame.origin.y, PTGMINScreenSide-2*leftEdge, buttonHeight)];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:mainColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)setShowRefreshIncon:(BOOL)showRefreshIncon {
    _showRefreshIncon = showRefreshIncon;
    if (showRefreshIncon) {
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateHighlighted];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    }
}

- (void)setIsValid:(BOOL)isValid {
    _isValid = isValid;
    self.enabled = isValid;
    if (isValid) {
        [self setBackgroundColor:mainColor];
    } else {
        [self setBackgroundColor:unValidColor];
    }
}
@end

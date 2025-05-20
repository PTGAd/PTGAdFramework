//
//  TGNativeDislikeButton.m
//  TGIOT
//
//  Created by Darren Xia on 2025/4/8.
//

#import "TGNativeDislikeButton.h"

@implementation TGNativeDislikeButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [self.currentTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    return CGRectMake(contentRect.origin.x + ceil(titleSize.width) + self.titleImgGap, contentRect.origin.y + (contentRect.size.height - imageSize.height) / 2, imageSize.width, imageSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGSize titleSize = [self.currentTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    return CGRectMake(contentRect.origin.x, contentRect.origin.y + (contentRect.size.height - ceil(titleSize.height)) / 2, ceil(titleSize.width), ceil(titleSize.height));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

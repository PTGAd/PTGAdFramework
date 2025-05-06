//
//  ATAutoLayout.h
//  AnythinkSDKDemo
//
//  Created by Jason on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(Autolayout)
+ (instancetype)autolayoutView;
@end

@interface UILabel(Autolayout)

+ (instancetype)autolayoutLabelFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)autolayoutLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END

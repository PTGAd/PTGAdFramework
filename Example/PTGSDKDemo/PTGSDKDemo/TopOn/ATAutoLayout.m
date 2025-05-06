//
//  ATAutoLayout.m
//  AnythinkSDKDemo
//
//  Created by Jason on 2021/10/29.
//

#import "ATAutoLayout.h"

@implementation UIView(Autolayout)
+ (instancetype)autolayoutView {
    UIView *view = [[self alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}
@end

@implementation UILabel(Autolayout)

+ (instancetype)autolayoutLabelFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [self autolayoutLabelFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)autolayoutLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel autolayoutView];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

@end

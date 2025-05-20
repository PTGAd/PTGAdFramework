//
//  UIView+TGExtension.m
//  AncloudCam
//
//  Created by Darren Xia on 2025/5/9.
//  Copyright © 2025 eye. All rights reserved.
//

#import "UIView+TGExtension.h"

@implementation UIView (TGExtension)

- (UIViewController *)tg_viewController{
    id next = [self nextResponder];
    while (next) {
        next = [next nextResponder];
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
    }
    return nil;
}

@end

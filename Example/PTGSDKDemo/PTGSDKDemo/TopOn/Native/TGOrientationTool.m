//
//  TGOrientationTool.m
//  AncloudCam
//
//  Created by Darren on 2024/9/10.
//  Copyright © 2024 eye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGOrientationTool.h"

@implementation TGOrientationTool

+ (void)appRotateToOrientation:(UIInterfaceOrientation)orientation controller:(nonnull UIViewController *)controller{
    if (@available(iOS 16.0, *)) {
        UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
        if (orientation == UIInterfaceOrientationPortrait){
            mask = UIInterfaceOrientationMaskPortrait;
        } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            mask = UIInterfaceOrientationMaskLandscapeLeft;
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            mask = UIInterfaceOrientationMaskLandscapeRight;
        }
        [controller setNeedsUpdateOfSupportedInterfaceOrientations];
        UIApplication *application = [UIApplication sharedApplication];
        UIWindowScene *windowScene = (UIWindowScene *)[application.connectedScenes allObjects][0];
        UIWindowSceneGeometryPreferencesIOS *preference = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:mask];
        [windowScene requestGeometryUpdateWithPreferences:preference errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"requestGeometryUpdate:%@", error);
        }];
    }else{
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val = (int)orientation;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }
    }
}

+ (UIDeviceOrientation)currentDeviceOrientation{
    UIDeviceOrientation deviceOrientation = UIDeviceOrientationPortrait;
    if (@available(iOS 16.0, *)) {
        UIApplication *application = [UIApplication sharedApplication];
        UIWindowScene *windowScene = (UIWindowScene *)[application.connectedScenes allObjects][0];
        UIInterfaceOrientation interfaceOrientation = windowScene.interfaceOrientation;
        if (interfaceOrientation == UIInterfaceOrientationPortrait) {
            deviceOrientation = UIDeviceOrientationPortrait;
        }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            deviceOrientation = UIDeviceOrientationLandscapeRight;
        }else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            deviceOrientation = UIDeviceOrientationLandscapeLeft;
        }
    }else{
        deviceOrientation = [UIDevice currentDevice].orientation;
    }
    return deviceOrientation;
}

@end

//
//  TGOrientationTool.h
//  AncloudCam
//
//  Created by Darren on 2024/9/10.
//  Copyright © 2024 eye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGOrientationTool : NSObject

+ (void)appRotateToOrientation:(UIInterfaceOrientation)orientation controller:(UIViewController *)controller;
+ (UIDeviceOrientation)currentDeviceOrientation;

@end

NS_ASSUME_NONNULL_END

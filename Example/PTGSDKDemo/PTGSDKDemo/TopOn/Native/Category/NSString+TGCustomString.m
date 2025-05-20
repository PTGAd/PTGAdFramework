//
//  NSString+TGCustomString.m
//  TGIOT
//
//  Created by Darren on 2024/4/8.
//

#import "NSString+TGCustomString.h"

@implementation NSString (TGCustomString)

+ (BOOL)tg_isInValidWithString:(NSString *)string{
    if (string && [string isKindOfClass:[NSString class]] && string.length) {
        return NO;
    }
    return YES;
}

- (BOOL)tg_ignoreCaseIsEqualToString:(NSString *)string{
    return [self compare:string options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
}

+ (NSString *)tg_getAppBundleIdentifier{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}

+ (BOOL)tg_isEmptyWithString:(NSString *)string{
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]]) {
        if (string.length == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

+ (NSString *)tg_getValueFromDictionary:(NSDictionary *)dictionary withKey:(NSString *)key{
    if (dictionary == nil || [NSString tg_isEmptyWithString:key]) {
        return @"";
    }
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    id value = [dictionary valueForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        if ([NSString tg_isEmptyWithString:value]) {
            return @"";
        }
        return value;
    } else if ([value isKindOfClass:[NSNull class]]) {
        return @"";
    } else if (value == nil) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@", value];
    }
}

@end

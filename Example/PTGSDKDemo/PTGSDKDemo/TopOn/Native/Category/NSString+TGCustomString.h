//
//  NSString+TGCustomString.h
//  TGIOT
//
//  Created by Darren on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TGCustomString)

+ (BOOL)tg_isInValidWithString:(NSString *)string;
- (BOOL)tg_ignoreCaseIsEqualToString:(NSString *)string;
+ (NSString *)tg_getAppBundleIdentifier;
+ (BOOL)tg_isEmptyWithString:(NSString *)string;
+ (NSString *)tg_getValueFromDictionary:(NSDictionary *)dictionary withKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

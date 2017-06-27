//
//  NSDictionary+WFSecurity.m
//  WFDataSecurityDemo
//
//  Created by hangmei on 2017/3/17.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import "NSDictionary+WFSecurity.h"
#import "NSObject+WFSecurity.h"
@implementation NSDictionary (WFSecurity)

- (NSString *)wf_stringForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    return [value wf_toString];
}

- (NSDictionary *)wf_dictionaryForKey:(NSString *)aKey{
    NSDictionary *value = [self objectForKey:aKey];
    return [value wf_toDictionary];
}

- (NSArray *)wf_arrayForKey:(NSString *)aKey{
    NSArray *value = [self objectForKey:aKey];
    return [value wf_toArray];
}

- (NSNumber *)wf_numberForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    return [value wf_toNumber];
}

- (BOOL)wf_boolForKey:(NSString *)aKey{
    NSString  *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return false;
}

- (NSInteger)wf_integerForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (long long)wf_longlongForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(longLongValue)]) {
        return [value longLongValue];
    }
    return 0;
}

- (double)wf_doubleForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return 0.f;
}

- (float)wf_floatForKey:(NSString *)aKey{
    NSString *value = [self objectForKey:aKey];
    if (value && [value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    return 0.f;
}

#pragma mark -- swizzle method
/*!
 @abstract load时通过方法交换处理
 objectForKey: key为nil；
 dictionaryWithObject:forKey: key/value 为nil
 */
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_dictionaryWithObject:forKey:) originClassName:@"__NSDictionaryI" originSel:@selector(dictionaryWithObject:forKey:)];
    });
}

+ (instancetype)wf_dictionaryWithObject:(id)object forKey:(NSString *)key{
    if (!key || !object) {
        return nil;
    }
    return [self wf_dictionaryWithObject:object forKey:key];
}

@end

@implementation NSMutableDictionary (WFSecurity)
/*!
 @abstract load时通过方法交换处理 
 setValue:forKey:  key/value 为nil；
 removeObjectForKey: key 为nil
 */
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_setValue:forKey:) originClassName:@"__NSDictionaryM" originSel:@selector(setValue:forKey:)];
        [self wf_swizzleMethod:@selector(wf_removeObjectForKey:) originClassName:@"__NSDictionaryM" originSel:@selector(removeObjectForKey:)];
    });
}

- (void)wf_setValue:(id)value forKey:(NSString *)key{
    if (!key || !value) {
        return;
    }
    [self wf_setValue:value forKey:key];
}

- (void)wf_removeObjectForKey:(NSString *)aKey{
    if (!aKey) {
        return;
    }
    [self wf_removeObjectForKey:aKey];
}

@end

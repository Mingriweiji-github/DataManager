//
//  NSObject+WFSecurity.m
//  Pods
//
//  Created by hangmei on 2017/3/21.
//
//

#import "NSObject+WFSecurity.h"
#import <objc/runtime.h>
@implementation NSObject (WFSecurity)
- (NSString *)wf_toString{
    if (self && [self isKindOfClass:[NSString class]]){
        return [self copy];
    }
    if (self && [self isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@",self];
    }
    return @"";
}

- (NSDictionary *)wf_toDictionary{
    if (self && [self isKindOfClass:[NSDictionary class]]) {
        return [self copy];
    }
    return @{};
}

- (NSArray *)wf_toArray{
    if (self && [self isKindOfClass:[NSArray class]]) {
        return [self copy];
    }
    return @[];
}

- (NSNumber *)wf_toNumber{
    if (self && [self isKindOfClass:[NSNumber class]]) {
        return [self copy];
    }
    return [NSNumber numberWithInteger:0];
}

@end

@implementation NSObject (Swizzling)
+ (void)wf_swizzleMethod:(SEL)newSel originSel:(SEL)originSel{
    [self wf_swizzleMethod:newSel originClass:[self class] originSel:originSel];
}

+ (void)wf_swizzleMethod:(SEL)newSel originClassName:(NSString *)originClassName originSel:(SEL)originSel{
    Class originClass = NSClassFromString(originClassName);
    [self wf_swizzleMethod:newSel originClass:originClass originSel:originSel];
}

+ (void)wf_swizzleMethod:(SEL)newSel originClass:(Class)originClass originSel:(SEL)originSel{
    if (!(newSel && originClass && originSel)) {
        return;
    }
    Method newMethod = class_getInstanceMethod([self class],newSel);
    Method originMethod = class_getInstanceMethod(originClass,originSel);
    method_exchangeImplementations(newMethod, originMethod);
}

@end

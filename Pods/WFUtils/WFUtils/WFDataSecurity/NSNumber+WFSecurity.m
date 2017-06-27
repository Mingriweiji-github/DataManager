//
//  NSNumber+WFSecurity.m
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/20.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import "NSNumber+WFSecurity.h"
#import "NSObject+WFSecurity.h"
@implementation NSNumber (WFSecurity)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_compare:) originSel:@selector(compare:)];
        [self wf_swizzleMethod:@selector(wf_isEqualToNumber:) originSel:@selector(isEqualToNumber:)];
    });
}

- (NSComparisonResult)wf_compare:(NSNumber *)otherNumber{
    if (!otherNumber) {
        return NSOrderedAscending;
    }
    return [self wf_compare:otherNumber];
}

- (BOOL)wf_isEqualToNumber:(NSNumber *)number{
    if (!number) {
        return false;
    }
    return [self wf_isEqualToNumber:number];
}

@end

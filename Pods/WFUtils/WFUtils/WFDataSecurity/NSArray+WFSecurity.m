//
//  NSArray+WFSecurity.m
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/17.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import "NSArray+WFSecurity.h"
#import "NSObject+WFSecurity.h"
@implementation NSArray (WFSecurity)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_arrayWithObject:) originClassName:@"__NSArrayI" originSel:@selector(arrayWithObject:)];
        [self wf_swizzleMethod:@selector(wf_objectAtIndex:) originClassName:@"__NSArrayI" originSel:@selector(objectAtIndex:)];
        [self wf_swizzleMethod:@selector(wf_arrayByAddingObject:) originClassName:@"__NSArrayI" originSel:@selector(arrayByAddingObject:)];
    });
}

+ (instancetype)wf_arrayWithObject:(id)anObject{
    if (!anObject) {
        return nil ;
    }
    return [self wf_arrayWithObject:anObject];
}

- (id)wf_objectAtIndex:(NSUInteger)index{
    if (index >= [self count]) {
        return nil;
    }
    return [self wf_objectAtIndex:index];
}

- (NSArray *)wf_arrayByAddingObject:(id)anObject{
    if (!anObject) {
        return self;
    }
    return [self wf_arrayByAddingObject:anObject];
}

@end

@implementation NSMutableArray (WFSecurity)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_addObject:) originClassName:@"__NSArrayM" originSel:@selector(addObject:)];
        [self wf_swizzleMethod:@selector(wf_insertObject:atIndex:) originClassName:@"__NSArrayM" originSel:@selector(insertObject:atIndex:)];
        [self wf_swizzleMethod:@selector(wf_removeObjectAtIndex:) originClassName:@"__NSArrayM" originSel:@selector(removeObjectAtIndex:)];
        [self wf_swizzleMethod:@selector(wf_replaceObjectAtIndex:withObject:) originClassName:@"__NSArrayM" originSel:@selector(replaceObjectAtIndex:withObject:)];
    });
}

- (void)wf_addObject:(id)anObject{
    if (!anObject) {
        return;
    }
    return [self wf_addObject:anObject];
}

- (void)wf_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (!anObject) {
        return;
    }
    if (index > [self count]) {
        return;
    }
    [self wf_insertObject:anObject atIndex:index];
}

- (void)wf_removeObjectAtIndex:(NSUInteger)index{
    if (index >= [self count]) {
        return;
    }
    return [self wf_removeObjectAtIndex:index];
}

- (void)wf_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (!anObject) {
        return;
    }
    if (index >= [self count]) {
        return;
    }
    return [self wf_replaceObjectAtIndex:index withObject:anObject];
}

@end

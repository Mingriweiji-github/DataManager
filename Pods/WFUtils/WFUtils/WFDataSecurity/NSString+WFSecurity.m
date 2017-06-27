//
//  NSString+WFSecurity.m
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/20.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import "NSString+WFSecurity.h"
#import "NSObject+WFSecurity.h"
@implementation NSString (WFSecurity)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_stringByAppendingString:) originClassName:@"__NSCFString" originSel:@selector(stringByAppendingString:)];
        [self wf_swizzleMethod:@selector(wf_characterAtIndex:) originClassName:@"__NSCFString" originSel:@selector(characterAtIndex:)];
        [self wf_swizzleMethod:@selector(wf_substringWithRange:) originClassName:@"__NSCFString" originSel:@selector(substringWithRange:)];
        [self wf_swizzleMethod:@selector(wf_substringFromIndex:) originClassName:@"__NSCFString" originSel:@selector(substringFromIndex:)];
        [self wf_swizzleMethod:@selector(wf_substringToIndex:) originClassName:@"__NSCFString" originSel:@selector(substringToIndex:)];
    });
}

- (NSString *)wf_stringByAppendingString:(NSString *)aString{
    if (!aString) {
        return self;
    }
    return [self wf_stringByAppendingString:aString];
}

- (unichar)wf_characterAtIndex:(NSUInteger)index{
    if (index >= [self length]) {
        return 0;
    }
    return [self wf_characterAtIndex:index];
}

- (NSString *)wf_substringWithRange:(NSRange)range{
    if (range.location > [self length]) {
        return @"";
    }
    if (range.location + range.length > [self length]) {
        return [self substringWithRange:NSMakeRange(range.location, [self length] - range.location)];
    }
    return [self wf_substringWithRange:range];
}

- (NSString *)wf_substringFromIndex:(NSUInteger)from{
    if (from > [self length]) {
        return @"";
    }
    return [self wf_substringFromIndex:from];
}

- (NSString *)wf_substringToIndex:(NSUInteger)to{
    if (to > [self length]) {
        return self;
    }
    return [self wf_substringToIndex:to];
}

@end

@implementation NSMutableString (WFSecurity)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wf_swizzleMethod:@selector(wf_appendString:) originClassName:@"__NSCFConstantString" originSel:@selector(appendString:)];
        [self wf_swizzleMethod:@selector(wf_insertString:atIndex:) originClassName:@"__NSCFConstantString" originSel:@selector(insertObject:atIndex:)];
        [self wf_swizzleMethod:@selector(wf_deleteCharactersInRange:) originClassName:@"__NSCFConstantString" originSel:@selector(deleteCharactersInRange:)];
    });
}

- (void)wf_appendString:(NSString *)aString{
    if (!aString) {
        return;
    }
    return[self wf_appendString:aString];
}

- (void)wf_insertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (!aString) {
        return;
    }
    if (loc > [self length]) {
        return;
    }
    [self wf_insertString:aString atIndex:loc];
}

- (void)wf_deleteCharactersInRange:(NSRange)range{
    if (range.location > [self length]) {
        return;
    }
    if (range.location + range.length > [self length]) {
        [self deleteCharactersInRange:NSMakeRange(range.location, [self length] - range.location)];
    }
    [self wf_deleteCharactersInRange:range];
}

@end

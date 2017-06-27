//
//  NSDictionary+WFSign.m
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "NSDictionary+WFSign.h"


@implementation NSDictionary (WFSign)

- (OrderedDictionary *)toOrderedDictionary {
    OrderedDictionary *oDic = [OrderedDictionary dictionaryWithDictionary:self];
    return oDic;
}

- (NSArray *)enumerateArray:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            obj = [dic toOrderedDictionary];
        }
    }];
    return array;
}

@end


@implementation NSArray (WFSign)

- (NSArray *)toArrayWithOrderdDictionarys {
    if (self) {
        NSMutableArray *tempValues = [self mutableCopy];
        for (id tmp in self) {
            if ([tmp isKindOfClass:[NSDictionary class]]
                && ![tmp isKindOfClass:[OrderedDictionary class]]) {
                NSInteger index = [tempValues indexOfObject:tmp];
                OrderedDictionary *dic = [OrderedDictionary dictionaryWithDictionary:tmp];
                tempValues[index] = dic;
                continue;
            }
            else if ([tmp isKindOfClass:[NSArray class]]) {
                NSInteger index = [tempValues indexOfObject:tmp];
                NSArray *array = [tmp toArrayWithOrderdDictionarys];
                tempValues[index] = array;
                continue;
            }
        }
        return tempValues;
    }
    else {
        return @[];
    }
}

@end


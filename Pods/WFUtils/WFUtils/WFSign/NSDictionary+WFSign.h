//
//  NSDictionary+WFSign.h
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedDictionary.h"


@interface NSDictionary (WFSign)


- (OrderedDictionary *)toOrderedDictionary;

@end


@interface NSArray (WFSign)

- (NSArray *)toArrayWithOrderdDictionarys;

@end

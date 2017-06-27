//
//  WFSign.m
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "WFSign.h"
#import "Base64.h"
#import "NSDictionary+WFSign.h"
#import "WFSignConfig.h"

@implementation WFSign

+ (NSString *)wfSign:(NSDictionary *)params {
    if (!params) {
        return nil;
    }
    OrderedDictionary *orderedDic = [params toOrderedDictionary];
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in orderedDic.allKeys) {
        id value = orderedDic[key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            NSData *json = [NSJSONSerialization dataWithJSONObject:value options:2 error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            [str appendString:[NSString stringWithFormat:@"%@%@", key, jsonStr]];
        }
        else {
            [str appendString:[NSString stringWithFormat:@"%@%@", key, value]];
        }
    }
    NSString *origin = [NSString stringWithFormat:@"%@%@",kSecretKEY,str];
    NSString *base64Str = [origin base64EncodedString];
    return [[NSString stringWithFormat:@"%@%@",base64Str,kSecretKEY] kWFMD5String];
}


+ (NSString *)reportSign:(NSDictionary *)params {
    if (!params) {
        return nil;
    }
    OrderedDictionary *orderedDic = [params toOrderedDictionary];
    NSMutableString *str = [NSMutableString string];
    NSString *dataStr = @"";
    for (NSString *key in orderedDic.allKeys) {
        id value = orderedDic[key];
        if ([key isEqualToString:@"data"]) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                id reportValue = value[@"clicks_info"];
                if (reportValue && ([reportValue isKindOfClass:[NSDictionary class]] || [reportValue isKindOfClass:[NSArray class]])) {
                    NSData *json = [NSJSONSerialization dataWithJSONObject:reportValue options:2 error:nil];
                    NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                    dataStr = [NSString stringWithFormat:@"dataclicks_info%@", [jsonStr base64EncodedString]];
                }
            }
        }
        else {
            [str appendString:[NSString stringWithFormat:@"%@%@", key, value]];
        }
    }
    [str appendString:dataStr];
    NSString *origin = [NSString stringWithFormat:@"%@%@%@",kSecretKEY,str,kSecretKEY];
    return [[origin base64EncodedString] kWFMD5String];
    return str;
}

+ (NSString *)uploadScannedHotspotsSign:(NSDictionary *)params {
    if (!params) {
        return nil;
    }
    OrderedDictionary *orderedDic = [params toOrderedDictionary];
    NSMutableString *str = [NSMutableString string];
    NSString *dataStr = @"";
    [str appendString:[NSString stringWithFormat:@"%@%@", @"timestamp", orderedDic[@"timestamp"]]];
    id reportValue = orderedDic[@"data"];
    if (reportValue && ([reportValue isKindOfClass:[NSDictionary class]] || [reportValue isKindOfClass:[NSArray class]])) {
        NSData *json = [NSJSONSerialization dataWithJSONObject:reportValue options:2 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        dataStr = [NSString stringWithFormat:@"data%@", [jsonStr base64EncodedString]];
    }
    else {
        [str appendString:[NSString stringWithFormat:@"%@%@", @"data", reportValue]];
    }
    [str appendString:dataStr];
    NSString *origin = [NSString stringWithFormat:@"%@%@%@",kSecretKEY,str,kSecretKEY];
    return [[origin base64EncodedString] kWFMD5String];
    return str;
}

@end

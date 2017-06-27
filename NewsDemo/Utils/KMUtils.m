//
//  KMUtils.m
//  NewsDemo
//
//  Created by Seven on 2017/6/26.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "KMUtils.h"
         /****************API**************/
NSString * const KBaseUrl = @"http://api.test.amol.com.cn:8083";
NSString * const KNewsAPI = @"/api/web/v1/third/ttnews";


__nullable id KUserDefaultsObjectForKey(NSString *key){
    if (!key) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

void KUserDefaultsSetObjectForKey(__nullable id obj,NSString *key){

    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
CGFloat kWFScale(CGFloat number) {
    return  number * kWFScreenWidth / 375;
}
UIColor * WFColorWithHex(long hex) {
    float red = ((float)((hex & 0xFF0000) >> 16)) / 255.0;
    float green = ((float)((hex & 0xFF00) >> 8)) / 255.0;
    float blue = ((float)(hex & 0xFF)) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@interface KMUtils ()
@property (nonatomic, strong) NSDateFormatter *newsDmt;
@property (nonatomic, strong) NSDateFormatter *newsLongDmt;

@end
@implementation KMUtils
+ (instancetype)sharedUtils {
    static KMUtils *kWFUtils = nil;
    static dispatch_once_t kWFUtilsOnceToken;
    dispatch_once(&kWFUtilsOnceToken, ^{
        kWFUtils = [[KMUtils alloc] init];
    });
    return kWFUtils;
}
- (NSDateFormatter *)newsDmt{
    if (!_newsDmt) {
        _newsDmt = [[NSDateFormatter alloc] init];
        _newsDmt.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        [_newsDmt setDateFormat:@"HH:mm"];
    }
    return _newsDmt;
}

- (NSDateFormatter *)newsLongDmt{
    
    if (!_newsLongDmt) {
        _newsLongDmt = [[NSDateFormatter alloc] init];
        _newsLongDmt.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        [_newsLongDmt setDateFormat:@"M月d日"];
    }
    return _newsLongDmt;
}
+ (NSString *)nowFromDateExchange:(NSString *)newsTime{
    
    NSInteger minute = 3600;
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime= [date timeIntervalSince1970];
    
    NSTimeInterval timeDiffrence = currentTime - [newsTime floatValue];
    if (timeDiffrence <= 60) {
        return @"刚刚";
    }else if (timeDiffrence < minute){
        return [NSString stringWithFormat:@"%.0f分钟前",timeDiffrence / 60];
    }else if (timeDiffrence <= 86400){
        return [NSString stringWithFormat:@"%.0f小时前",timeDiffrence / 3600];
    }else if (timeDiffrence <= (minute * 24 * 2)){
        NSDate *espleseTime = [NSDate dateWithTimeIntervalSince1970:[newsTime floatValue]];
        NSString *timeStr = [[KMUtils sharedUtils].newsDmt stringFromDate:espleseTime];
        return [NSString stringWithFormat:@"昨天%@",timeStr];
    }else if (timeDiffrence <= (minute * 24 * 3)){
        NSDate *espleseTime = [NSDate dateWithTimeIntervalSince1970:[newsTime floatValue]];
        NSString *timeStr = [[KMUtils sharedUtils].newsDmt stringFromDate:espleseTime];
        return [NSString stringWithFormat:@"前天%@",timeStr];
    }else if (timeDiffrence <= (minute * 24 * 10)){
        return [NSString stringWithFormat:@"%.0f天前", timeDiffrence / (minute * 24)];
    }else{
        NSDate *espleseTime = [NSDate dateWithTimeIntervalSince1970:[newsTime floatValue]];
        NSString *time = [[KMUtils sharedUtils].newsLongDmt stringFromDate:espleseTime];
        return time;
    }
    
}
@end

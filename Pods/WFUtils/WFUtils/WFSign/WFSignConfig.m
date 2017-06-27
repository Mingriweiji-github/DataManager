//
//  WFSignConfig.m
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "WFSignConfig.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const kSecretKEY = @"c6a8d7a02fa9b971b8603e4641ae473e";

@implementation WFSignConfig

@end

@implementation NSString (WFMD5)

- (NSString *)kWFMD5String {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

@end

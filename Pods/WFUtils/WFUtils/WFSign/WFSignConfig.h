//
//  WFSignConfig.h
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kSecretKEY;

@interface WFSignConfig : NSObject

@end


@interface NSString (WFMD5)

- (NSString *)kWFMD5String;

@end

//
//  KMNetWorkManager.h
//  NewsDemo
//
//  Created by Seven on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,WFResponseType){

    kWFResponseTypeJSON = 1,
    kWFResponseTypeXML = 2,
    kWFResponseTypeData,
};
typedef NS_ENUM(NSUInteger,WFRequestType) {

    kWFRequestTypeJSON = 1,
    kWFRequestTypePlainText = 2,
};


@class NSURLSessionTask;
typedef NSURLSessionTask WFURLSessionTask;
typedef void(^WFResponseSuccess)(id response);
typedef void(^WFResponseFail)(NSError *error);

typedef void(^CompletionHandle)(id result);
typedef void(^FailedHandle)(id result);

@interface KMNetWorkManager : NSObject
+ (NSString *)baseUrl;

+ (void)setTimeout:(NSTimeInterval)timeout;


+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;


+ (WFURLSessionTask *)getWithUrl:(NSString *)url
                          params:(nullable NSDictionary *)params
                         success:(WFResponseSuccess)success
                            fail:(WFResponseFail)fail;


@end
NS_ASSUME_NONNULL_END

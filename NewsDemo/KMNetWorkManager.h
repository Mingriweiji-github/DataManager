//
//  KMNetWorkManager.h
//  NewsDemo
//
//  Created by Seven on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,WFResponseType){

    kWFResponseTypeJSON = 1,
    kWFResponseTypeXML = 2,
    kWFResponseTypeData,
};
typedef NS_ENUM(NSUInteger,WFReqeustType) {

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
//+ (NSString *)baseUrl;
//
//+ (void)setTimeout:(NSTimeInterval)timeout;
//
///*!
// *
// *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
// *
// *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
// */
//+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;
//
//+ (void)cancelRequestWithURL:(NSString *)url;
//
//+ (WFURLSessionTask *)getWithUrl:(NSString *)url
//                    refreshCache:(BOOL)refreshCache
//                         success:(WFResponseSuccess)success
//                            fail:(WFResponseFail)fail;
//
//+ (WFURLSessionTask *)getWithUrl:(NSString *)url
//                    refreshCache:(BOOL)refreshCache
//              previousCachedData:(WFResponseSuccess)preCachedData
//                         success:(WFResponseSuccess)success
//                            fail:(WFResponseFail)fail;


+(void)GetRequestUrl:(NSString *)url
              Params:(id)params
          completion:(CompletionHandle)block
              failed:(FailedHandle)failedBlock;

+(void)PostRequestUrl:(NSString *)url
               Params:(id)params
           completion:(CompletionHandle)block
               failed:(FailedHandle)failedBlock;
@end
NS_ASSUME_NONNULL_END

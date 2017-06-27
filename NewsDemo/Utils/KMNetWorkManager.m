//
//  KMNetWorkManager.m
//  NewsDemo
//
//  Created by Seven on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "KMNetWorkManager.h"
#import "WFModel.h"
static WFResponseType sg_responseType = kWFResponseTypeJSON;
static WFRequestType  sg_requestType  = kWFRequestTypeJSON;
static NSDictionary *sg_httpHeaders = nil;
static NSTimeInterval sg_timeout = 30.0f;
static NSMutableArray *allRequestTasks;

@implementation KMNetWorkManager
#pragma mark public
+ (void)setTimeout:(NSTimeInterval)timeout {
    sg_timeout = timeout;
}
+ (NSString *)baseUrl {
    return KBaseUrl;
}
#pragma mark private
+ (AFHTTPSessionManager *)manager{

    static AFHTTPSessionManager *manager = nil;
    if (!manager) {
        if ([self baseUrl]) {
            manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
        }else{
            manager = [AFHTTPSessionManager manager];
        }
    }
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    for (NSString *key in sg_httpHeaders.allKeys) {
        if (sg_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:sg_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    manager.requestSerializer.timeoutInterval = sg_timeout;
    
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    return manager;
}
//Get
+ (WFURLSessionTask *)getWithUrl:(NSString *)url
                          params:(nullable NSDictionary *)params
                         success:(WFResponseSuccess)success
                            fail:(WFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [self manager];
    NSString *absolute = [self absoluteUrlWithPath:url];
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            return nil;
        }
    }else{
    
        NSURL *absoluteUrl = [NSURL URLWithString:absolute];
        if (absoluteUrl == nil) {
            return nil;
        }
    }
    WFURLSessionTask *session = nil;
    session = [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self successResponse:responseObject callBack:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}
+ (void)successResponse:(id)response callBack:(WFResponseSuccess)success{

    if (success) {
        success([self parseData:response]);
    }
}
+ (id)parseData:(id)responseData{
    if (!responseData) {
        return nil;
    }
    if ([responseData isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if (error != nil) {
            return responseData;
        }
        WFModel *model = [[WFModel alloc] initWithDictionary:responseDic];
        if (model.error_code) {
            return model;
        }else{
            return responseData;
        }
    }else{
        WFModel *model = [[WFModel alloc] initWithDictionary:responseData];
        if (model.error_code) {
            return model;
        }else{
            return responseData;
        }
    }
    
}
+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        }else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    
    return absoluteUrl;
}
+ (NSMutableArray *)allTasks{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!allRequestTasks) {
            allRequestTasks = [[NSMutableArray alloc] init];
        }
    });
    
    return allRequestTasks;
}

@end

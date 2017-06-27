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
@interface KMUtils ()


@end
@implementation KMUtils

@end

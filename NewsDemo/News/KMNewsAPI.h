//
//  KMNewsAPI.h
//  NewsDemo
//
//  Created by M_Li on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KMNewsModel;

@interface KMNewsAPI : NSObject
+ (void)getNewsWithParam:(NSDictionary *)params Success:(WFResponseSuccess)success failure:(WFResponseFail)fail;
@end

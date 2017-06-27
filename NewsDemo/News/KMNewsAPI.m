//
//  KMNewsAPI.m
//  NewsDemo
//
//  Created by M_Li on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "KMNewsAPI.h"
#import "KMNewsModel.h"

@implementation KMNewsAPI
+ (void)getNewsWithParam:(NSDictionary *)params Success:(WFResponseSuccess)success failure:(WFResponseFail)fail{
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:params options:2 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    NSString *url = [KNewsAPI stringByAppendingFormat:@"?param=%@", [jsonStr kWFURLEncodeString]];
    
    [KMNetWorkManager getWithUrl:url params:nil success:^(id  _Nonnull response) {
        if (response && [response isKindOfClass:[WFModel class]]) {
            WFModel *model = response;
            NSLog(@"response=%@",response);
            if ([model.error_code integerValue]== 0) {
                NSMutableArray *arr = [NSMutableArray array];
                if (!model.data || ![model.data isKindOfClass:[NSDictionary class]]) {
                    return ;
                }
                if (model.data[@"list"] != nil) {
                    if ([model.data[@"list"] count] > 0) {
                        arr = [KMNewsModel mj_objectArrayWithKeyValuesArray:model.data[@"list"]];
                        if (arr.count) {
                            success(arr);
                        }
                    }
                }
            }
        
        }
        
    } fail:^(NSError * _Nonnull error) {
        
        
    }];
}
@end

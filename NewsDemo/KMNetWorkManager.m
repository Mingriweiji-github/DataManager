//
//  KMNetWorkManager.m
//  NewsDemo
//
//  Created by Seven on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "KMNetWorkManager.h"

@implementation KMNetWorkManager

+(void)GetRequestUrl:(NSString *)url
              Params:(NSMutableArray *)params
          completion:(CompletionHandle)block
              failed:(FailedHandle)failedBlock{
    NSString *urlString = [[NSMutableString alloc] initWithFormat:@"%@%@",HOSTSERVER,KNewsAPI];
    NSString *str_url;
    NSMutableString *str_temp = [[NSMutableString alloc] init];
    
    params = (NSMutableArray*)params;
    
    for (int i = 0; i < params.count ; i++) {
        NSString * key_str = [params objectAtIndex:i];
        [str_temp appendFormat:@"%@",key_str];
        if (i != params.count - 1) {
            [str_temp appendString:@"/"];
        }
    }
    str_url = [NSString stringWithFormat:@"%@%@",urlString,str_temp];
    NSLog(@"-->GET->urlString: %@", [NSString stringWithFormat:@"%@%@",urlString,str_temp]);
    str_url = [str_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    


}

+(void)PostRequestUrl:(NSString *)url
               Params:(id)params
           completion:(CompletionHandle)block
               failed:(FailedHandle)failedBlock{



}
@end

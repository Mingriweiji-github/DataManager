//
//  WFSign.h
//  WangFan
//
//  Created by meiyuanyuan on 2017/5/18.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFSign : NSObject

/*!
  @abstract 服务端统一sign规则
 */
+ (NSString *)wfSign:(NSDictionary *)params;



/*!
 @abstract 上报信息sign规则
 */
+ (NSString *)reportSign:(NSDictionary *)params;

+ (NSString *)uploadScannedHotspotsSign:(NSDictionary *)params;

@end

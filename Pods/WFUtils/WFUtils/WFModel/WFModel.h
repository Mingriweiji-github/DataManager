//
//  WFModel.h
//  Pods
//
//  Created by hangmei on 2017/3/21.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface WFModel : NSObject

@property (nonatomic, strong)   NSNumber *error_code;
@property (nonatomic, copy)     NSString *error_msg;
@property (nonatomic, strong)   NSDictionary *data;
@property (nonatomic, strong, readonly) NSDictionary *responseInfo;

- (instancetype)initWithDictionary:(NSDictionary *)data NS_DESIGNATED_INITIALIZER;

@end

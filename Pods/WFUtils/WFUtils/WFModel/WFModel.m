//
//  WFModel.m
//  Pods
//
//  Created by hangmei on 2017/3/21.
//
//

#import "WFModel.h"
@interface WFModel ()

@property (nonatomic, strong, readwrite) NSDictionary *responseInfo;

@end

@implementation WFModel

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            self.responseInfo = data;
            [self setValuesForKeysWithDictionary:data];
        }
        if (![self.data isKindOfClass:[NSDictionary class]] && ![self.data isKindOfClass:[NSArray class]]) {
            self.responseInfo = @{};
            self.data = @{};
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

#pragma mark - description

- (NSString *)description {
    return [NSString stringWithFormat:@"WFModel info -- \n error_code : %@ \n error_msg : %@ \n data : %@", self.error_code, self.error_msg, self.data];
}

@end

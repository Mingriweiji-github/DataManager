//
//  KMUtils.h
//  NewsDemo
//
//  Created by Seven on 2017/6/26.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const kAPIHostDevelop;
FOUNDATION_EXPORT NSString * const KNewsAPI;
FOUNDATION_EXPORT __nullable id KUserDefaultsObjectForKey(NSString * _Nullable key);
FOUNDATION_EXPORT void KUserDefaultsSetObjectForKey(__nullable id obj,NSString * _Nullable key);

@interface KMUtils : NSObject

@end
NS_ASSUME_NONNULL_END

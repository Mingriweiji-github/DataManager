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
FOUNDATION_EXPORT NSString * const KBaseUrl;
FOUNDATION_EXPORT NSString * const KNewsAPI;
FOUNDATION_EXPORT __nullable id KUserDefaultsObjectForKey(NSString * _Nullable key);
FOUNDATION_EXPORT void KUserDefaultsSetObjectForKey(__nullable id obj,NSString * _Nullable key);
FOUNDATION_EXPORT CGFloat kWFScale(CGFloat number);
FOUNDATION_EXPORT UIColor * WFColorWithHex(long hex);

@interface KMUtils : NSObject
/**
 新闻发布时间对比
 
 */
+ (NSString *)nowFromDateExchange:(NSString *)newsTime;

@end

// MARK: UIView Category
@interface UIView (CornerRadius)
@property (assign, nonatomic) IBInspectable CGFloat  cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat  borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@end
NS_ASSUME_NONNULL_END

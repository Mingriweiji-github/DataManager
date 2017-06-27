//
//  NSObject+WFSecurity.h
//  Pods
//
//  Created by hangmei on 2017/3/21.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (WFSecurity)
/*!
 @abstract 将当前对象转化为NSString对象
 */
- (NSString *)wf_toString;

/*!
 @abstract 将当前对象转化为NSDictionary对象
 */
- (NSDictionary *)wf_toDictionary;

/*!
 @abstract 将当前对象转化为NSArray对象
 */
- (NSArray *)wf_toArray;

/*!
 @abstract 将当前对象转化为NSNumber对象
 */
- (NSNumber *)wf_toNumber;

@end

@interface NSObject (Swizzling)

/*!
 @abstract swizzle method in a class
 @param newSel new Method
 @param originSel systemMethod
 */
+ (void)wf_swizzleMethod:(SEL)newSel originSel:(SEL)originSel;


/**
 swizzle method between two diffrente classes;
 
 @param newSel new Method
 @param originClassName systemMethod className
 @param originSel systemMethod
 */
+ (void)wf_swizzleMethod:(SEL)newSel originClassName:(NSString *)originClassName originSel:(SEL)originSel;

@end

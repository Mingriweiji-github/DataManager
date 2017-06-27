//
//  NSDictionary+WFSecurity.h
//  WFDataSecurityDemo
//
//  Created by hangmei on 2017/3/17.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @abstract 1. 将获取的任意类型的value 转化为 需要的类型  2.load时通过方法交换处理  objectForKey: key为nil； dictionaryWithObject:forKey: key/value 为nil 调用以上系统方法时,无需再进行判断。
 */
@interface NSDictionary (WFSecurity)

/*!
 @abstract 将获取的任意类型的value 转化为 NSString类型的对象
 @param aKey NSString类型，可以为nil
 @return  NSString类型的对象
 */
- (NSString *)wf_stringForKey:(NSString *)aKey;


/*!
 将获取的的任意类型的value 转化为 NSDictionary类型的对象
 @param aKey NSString类型的key，可以为nil
 @return  NSDictionary类型的对象
 */
- (NSDictionary *)wf_dictionaryForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为 NSArray类型的对象
 @param aKey NSString类型，可以为nil
 @return  NSArray类型的对象
 */
- (NSArray *)wf_arrayForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为 NSNumber类型的对象
 @param aKey NSString类型，可以为nil
 @return  NSNumber类型的对象
 */
- (NSNumber *)wf_numberForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为 BOOL类型的值
 @param aKey NSString类型，可以为nil
 @return  BOOL类型的值
 */
- (BOOL)wf_boolForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为  NSInteger类型的值
 @param aKey NSString类型，可以为nil
 @return  NSInteger类型的值
 */
- (NSInteger)wf_integerForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为  long long类型的值
 @param aKey NSString类型，可以为nil
 @return  long long类型的值
 */
- (long long)wf_longlongForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为  double类型的值
 @param aKey NSString类型，可以为nil
 @return  double类型的值
 */
- (double)wf_doubleForKey:(NSString *)aKey;


/*!
 @abstract 将获取的任意类型的value 转化为  float类型的值
 @param aKey NSString类型，可以为nil
 @return  float类型的值
 */
- (float)wf_floatForKey:(NSString *)aKey;

@end


/*!
 @abstract load时通过方法交换处理
 setValue:forKey:  key/value 为nil；
 removeObjectForKey: key 为nil
 直接引入NSDictionary+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSMutableDictionary(WFSecurity)

@end

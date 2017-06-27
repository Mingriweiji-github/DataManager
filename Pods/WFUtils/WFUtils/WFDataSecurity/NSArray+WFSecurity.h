//
//  NSArray+WFSecurity.h
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/17.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @abstract load时通过方法交换处理：
 arrayWithObject: 参数为nil
 objectAtIndex: 取值越界
 arrayByAddingObject: 添加对象为nil
 直接引入NSArray+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSArray (WFSecurity)

@end

/*!
 @abstract load时通过方法交换处理：
 addObject: 添加对象为nil;
 insertObject:atIndex: 插入对象为nil 和 index越界；
 removeObjectAtIndex: 删除对象index越界；
 replaceObjectAtIndex:withObject: 交换对象为nil，index越界；
 直接引入NSArray+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSMutableArray (WFSecurity)

@end

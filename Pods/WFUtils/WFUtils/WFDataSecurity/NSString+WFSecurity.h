//
//  NSString+WFSecurity.h
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/20.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @abstract load时通过方法交换处理
 stringByAppendingString: 拼接的字符串对象为空；
 characterAtIndex: 越界问题；
 substringWithRange: 字符串截取越界；
 substringFromIndex: 字符串截取越界；
 substringToIndex: 字符串截取越界；
 直接引入NSString+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSString (WFSecurity)

@end


/*!
 @abstract load时通过方法交换处理
 appendString:拼接的字符串对象为nil
 insertObject:atIndex: 插入的字符串对象为nil,插入位置越界
 deleteCharactersInRange: 删除字符串越界
 直接引入NSString+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSMutableString (WFSecurity)

@end

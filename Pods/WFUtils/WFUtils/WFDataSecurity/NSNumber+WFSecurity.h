//
//  NSNumber+WFSecurity.h
//  WFSecurityDemo
//
//  Created by hangmei on 2017/3/20.
//  Copyright © 2017年 hangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @abstract load时通过方法交换处理：
 compare: 参数为nil
 isEqualToNumber: 参数为nil
 直接引入NSNumber+WFSecurity.h文件 调用以上系统方法时,无需再进行判断。
 */
@interface NSNumber (WFSecurity)

@end

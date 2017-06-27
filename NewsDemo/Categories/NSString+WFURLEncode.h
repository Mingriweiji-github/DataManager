//
//  NSString+WFURLEncode.h//
//  Copyright © 2016年 WS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WFURLEncode)

/*!
 *  @brief  对string进行urlencode编码。
 *
 *  @return 编码后的string。
 */
- (NSString *)kWFURLEncodeString;

@end

@interface NSString (WFMD5)

- (NSString *)kWFMD5String;

@end

@interface NSString (WFInputCheck)

- (BOOL)kWFIsPhoneNumber;

@end

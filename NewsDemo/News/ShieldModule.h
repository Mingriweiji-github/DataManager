//
//  WFShieldView.h
//  WangFan
//
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Completed)();
typedef void(^Canceled)();
@interface ShieldModule : NSObject


/**
 弹出不感兴趣页面

 @param point  当前触摸的位置
 @param completed  点击了不感兴趣按钮的回调
 @param canceled  点击空白处关闭屏蔽按钮的回调
 */
+ (void)showShieldViewWithPoint:(CGPoint)point completed:(Completed)completed canceled:(Canceled)canceled;

@end

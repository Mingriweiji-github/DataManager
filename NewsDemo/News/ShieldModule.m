//
//  WFShieldView.m
//  WangFan
//
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "ShieldModule.h"
#import "KMUtils.h"
static NSTimeInterval const animationTime = 0.12;
static CGFloat const btnW = 105;
static CGFloat const btnH = 30;
@interface ShieldModule()
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) Completed completed;
@property (nonatomic, copy) Canceled canceled;
@end
@implementation ShieldModule

+ (instancetype)sharedShieldView {
    static ShieldModule *shield = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shield = [[self alloc]init];
        
    });
    return shield;
}

+ (void)showShieldViewWithPoint:(CGPoint)point completed:(Completed)completed canceled:(Canceled)canceled {
    
    ShieldModule *module = [self sharedShieldView];
    [module setupWindow];
    [module setupBtnWithPoint:point];
    module.completed = completed;
    module.canceled = canceled;
}

- (void)setupBtnWithPoint:(CGPoint)point {
    
    //黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:self.window.bounds];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.window addSubview:bgView];
    UITapGestureRecognizer *cancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [bgView addGestureRecognizer:cancel];
    
    //不感兴趣按钮
    CGFloat btnY = point.y - btnH * 0.5;
    
    UIButton *btn = [[UIButton alloc] init];
    self.btn = btn;
    btn.frame = CGRectMake(point.x, btnY, 0, btnH);
    [btn setBackgroundColor:WFColorWithHex(0xff7733)];
    [btn setTitle:@"不感兴趣" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.cornerRadius = 4;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn addTarget:self action:@selector(tapUnInterestBtn) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    [UIView animateWithDuration:animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [btn setFrame:CGRectMake(point.x - 10 - btnW,  btnY, btnW, btnH)];
        btn.cornerRadius = 15;

    } completion:^(BOOL finished) {
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];

    }];
}

- (void)setupWindow {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.userInteractionEnabled = YES;
    self.window = window;
    window.alpha = 0;
    [UIView animateWithDuration:animationTime animations:^{
    } completion:^(BOOL finished) {
        window.alpha = 1;

    }];
}

- (void)tapUnInterestBtn {
    if (self.completed) {
        self.completed();
    }
    [self dismiss];
}

- (void)cancel {
    if (self.canceled) {
        self.canceled();
    }
    [self dismiss];
}

- (void)dismiss {

    [UIView animateWithDuration:animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.btn.frame;
        [self.btn setFrame:CGRectMake(frame.origin.x + frame.size.width,  frame.origin.y, 0, btnH)];
        self.window.alpha = 0;

    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^(UIView  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}

@end

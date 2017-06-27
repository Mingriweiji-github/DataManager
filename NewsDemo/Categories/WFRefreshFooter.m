//
//  WFRefreshFooter.m
//  WangFan
//
//  Created by lyf on 17/3/10.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "WFRefreshFooter.h"
#import "SVIndefiniteAnimatedView.h"
@interface WFRefreshFooter ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIActivityIndicatorView *load;


@end


@implementation WFRefreshFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)prepare{
    [super prepare];

    self.mj_h = 50;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = WFColorWithHex(0x807e7d);
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.load = loading;
    
    self.label.frame = CGRectMake(0, 0, 100, 30);
    loading.frame = CGRectMake(CGRectGetMaxX(self.label.frame), 0, 20, 30);
    
}


- (void)placeSubviews{
    [super placeSubviews];
    
    self.label.center = CGPointMake(self.mj_w/2, self.mj_h/2);
    _load.frame = CGRectMake(CGRectGetMaxX(self.label.frame), 0, 20, 30);
    CGPoint center = _load.center;
    center.y = self.label.center.y;
    _load.center = center;
}



- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载更多";
            [self.load stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在努力加载";
            [self.load startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"没有更多数据了...";
            [self.load stopAnimating];
            break;
        default:
            break;
    }
}


@end

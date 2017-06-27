//
//  WFRefreshHeader.m
//  WangFan
//
//  Created by lyf on 16/11/24.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFRefreshHeader.h"

@interface WFRefreshHeader ()

@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组


@end


@implementation WFRefreshHeader

- (void)prepare{
    [super prepare];
    [self setImages:self.normalImages forState:MJRefreshStateIdle];
    [self setImages:self.refreshImages forState:MJRefreshStatePulling];
    [self setImages:self.refreshImages duration:.5f forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden= YES;
    self.stateLabel.hidden = YES;
}


- (void)placeSubviews{
    
    [super placeSubviews];
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    self.gifView.frame = CGRectMake(self.gifView.frame.size.width / 2 - 25, 15, 50,30);
    self.mj_h = 60;
}
/**
 *
 *  普通状态下的图片
 */
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i< 2 ; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
            [self.normalImages addObject:image];
        }
    }
    return _normalImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i<=8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
          
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}


@end

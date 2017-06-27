//
//  KMNewsModel.h
//  NewsDemo
//
//  Created by M_Li on 2017/6/27.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMNewsModel : NSObject
/**
 新闻类型
 */
@property(nonatomic,copy) NSString *feedsType;
/**
 新闻来源
 */
@property(nonatomic,copy) NSString *from;
/**
 文章标题
 */
@property(nonatomic,copy) NSString *title;

@property(nonatomic,strong) NSArray *images;
/**
 播放时长
 */
@property(nonatomic,assign) NSInteger runtime;
/**
 是否大图
 */
@property(nonatomic,assign) NSInteger isBigPic;

/**
 跳转url
 */
@property(nonatomic,copy) NSString *url;

/**
 elapseTime 发布时间
 */
@property(nonatomic,copy) NSString *elapseTime;

/**
 文章评论数
 */
@property(nonatomic,copy) NSString *commentNum;

@property(nonatomic,assign) BOOL isSelect;

/**
 广告id
 */
@property(nonatomic,assign) NSInteger ad_id;


/**
 新闻id
 */
@property(nonatomic,assign) NSInteger group_id;

/**
 上报id 不感兴趣
 */
@property(nonatomic,assign) NSInteger item_id;


@property(nonatomic,copy) NSString *log_extra;
/**
 所属频道
 */
@property(nonatomic,copy) NSString *tag;
//所属分类
@property(nonatomic,copy) NSString *channel;
//视频观看数
@property(nonatomic,assign) NSInteger video_watch_count;
@end

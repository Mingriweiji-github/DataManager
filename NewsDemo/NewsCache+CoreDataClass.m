//
//  NewsCache+CoreDataClass.m
//  
//
//  Created by M_Li on 2017/6/28.
//
//

#import "NewsCache+CoreDataClass.h"

@implementation NewsCache
- (void)cacheWithModel:(KMNewsModel *)model{
    
    if (model) {
        self.title = model.title;
        self.runtime = model.runtime;
        self.from = model.from;
        self.feedsType = model.feedsType;
        if (model.images) {
            self.images = model.images;
        }
        self.url = model.url;
        self.elapseTime = model.elapseTime;
        self.runtime = model.runtime;
        self.isBigPic = model.isBigPic;
        self.ad_id = model.ad_id;
        self.group_id = model.group_id;
        self.item_id = model.item_id;
        self.log_extra = model.log_extra;
        self.tag = model.tag;
    }else{
        NSLog(@"NewsCache model 为空");
    }
}

@end

//
//  NewsCache+CoreDataProperties.m
//  
//
//  Created by Seven on 2017/6/28.
//
//

#import "NewsCache+CoreDataProperties.h"

@implementation NewsCache (CoreDataProperties)

+ (NSFetchRequest<NewsCache *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NewsCache"];
}

@dynamic ad_id;
@dynamic commentNum;
@dynamic elapseTime;
@dynamic feedsType;
@dynamic from;
@dynamic group_id;
@dynamic images;
@dynamic isBigPic;
@dynamic item_id;
@dynamic log_extra;
@dynamic runtime;
@dynamic tag;
@dynamic title;
@dynamic url;

@end

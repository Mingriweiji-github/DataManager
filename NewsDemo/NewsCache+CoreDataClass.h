//
//  NewsCache+CoreDataClass.h
//  
//
//  Created by M_Li on 2017/6/28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KMNewsModel.h"

@class NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface NewsCache : NSManagedObject

- (void)cacheWithModel:(KMNewsModel *)model;

@end

NS_ASSUME_NONNULL_END

#import "NewsCache+CoreDataProperties.h"

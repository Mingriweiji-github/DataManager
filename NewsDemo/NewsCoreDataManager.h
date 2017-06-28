//
//  NewsCoreDataManager.h
//  NewsDemo
//
//  Created by Seven on 2017/6/28.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
@interface NewsCoreDataManager : NSObject
@property (nonatomic, strong,readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, strong,readonly) NSManagedObjectContext *bgContext;

+ (instancetype)manager;

- (void)saveWithContext:(NSManagedObjectContext *)ctx;
- (NSArray *)getNewsCache;
- (void)removeCache;
- (NSArray *)getAllCache;
@end
NS_ASSUME_NONNULL_END

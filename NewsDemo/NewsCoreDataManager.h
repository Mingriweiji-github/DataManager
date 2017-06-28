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

/*保存数据 */
- (void)saveWithContext:(NSManagedObjectContext *)ctx;

//插入数据 直接插入数组（model）
- (void)insertCoreData:(NSMutableArray*)dataArray;
//获取数据
- (NSArray *)getNewsCache;

- (void)removeCache;
@end
NS_ASSUME_NONNULL_END

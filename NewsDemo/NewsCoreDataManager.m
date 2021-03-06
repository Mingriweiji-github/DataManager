//
//  NewsCoreDataManager.m
//  NewsDemo
//
//  Created by Seven on 2017/6/28.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "NewsCoreDataManager.h"
#import "NewsCache+CoreDataClass.h"

@interface NewsCoreDataManager ()
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSManagedObjectContext *bgContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end
@implementation NewsCoreDataManager
+ (instancetype)manager{

    static dispatch_once_t onceToken;
    static NewsCoreDataManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NewsCoreDataManager alloc] init];
    });
    
    return sharedInstance;
}
#pragma mark public
- (void)saveWithContext:(NSManagedObjectContext *)ctx{

    NSError *error;
   __block BOOL saved = [ctx save:&error];
    if (saved && ctx.parentContext) {
        [ctx.parentContext performBlockAndWait:^{
            NSError *err;
            saved = [ctx.parentContext save:&err];
            if (!saved) {
                NSLog(@"ctx parent saved error:%@",err);
            }else{
                NSLog(@"ctx saved success");
                
            }
            
        }];
    }else{
        NSLog(@"ctx saved error:%@",error);
    }
}
#pragma mark - getter
- (NSURL *)applicationDocumentsDirectory{

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
}
- (NSManagedObjectModel *)managedObjectModel{

    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewsDB" withExtension:@"momd"];

        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSLog(@"%@", [self applicationDocumentsDirectory]);
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewsDB.sqlite"];
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @(YES), NSMigratePersistentStoresAutomaticallyOption,
                             @(YES), NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        return [self persistentStoreCoordinator];
    }
    NSLog(@"init persistentStoreCoordinator success.");
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)bgContext{
    if (!_bgContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (!coordinator) {
            return nil;
        }
        _bgContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _bgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        _bgContext.persistentStoreCoordinator = coordinator;
    }
    return _bgContext;
}
- (NSManagedObjectContext *)mainContext{

    if (!_mainContext) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        _mainContext.parentContext = self.bgContext;
    }

    return _mainContext;
}
//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray
{
    [self removeCache];
    
    NSManagedObjectContext *ctx = [NewsCoreDataManager manager].mainContext;
    for (KMNewsModel *model in dataArray) {
        //把model直接赋值momd中的实体NSEntityDescription
        NewsCache *newsCache = [NSEntityDescription insertNewObjectForEntityForName:@"NewsCache" inManagedObjectContext:ctx];
        newsCache.title = model.title;
        newsCache.runtime = model.runtime;
        newsCache.from = model.from;
        newsCache.feedsType = model.feedsType;
        if (model.images) {
            newsCache.images = model.images;
        }
        newsCache.url = model.url;
        newsCache.elapseTime = model.elapseTime;
        newsCache.runtime = model.runtime;
        newsCache.isBigPic = model.isBigPic;
        newsCache.ad_id = model.ad_id;
        newsCache.group_id = model.group_id;
        newsCache.item_id = model.item_id;
        newsCache.log_extra = model.log_extra;
        newsCache.tag = model.tag;
        newsCache.isSelect = model.isSelect;
        
        if ([ctx hasChanges]) {
            [self saveWithContext:ctx];
        }
        
        NSError *error;
        if(![ctx save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
}
- (NSArray *)getNewsCache{

    NSManagedObjectContext *ctx = [[NewsCoreDataManager manager] mainContext];
    //    [NSFetchRequest fetchRequestWithEntityName:@"NewsCache"];
    NSFetchRequest *request = [NewsCache fetchRequest];
//    request.fetchLimit = 20;
    
    NSArray *result = [ctx executeFetchRequest:request error:nil];
    NSLog(@"获取缓存result.count=%ld",result.count);
    if (result && result.count) {
        return result;
    }else{
        return @[];
    }
}
- (void)removeCache{

    NSManagedObjectContext *ctx = [[NewsCoreDataManager manager] mainContext];
    NSFetchRequest *fetchRequest = [NewsCache fetchRequest];
    fetchRequest.includesPropertyValues = NO;
    NSError *error;
    NSArray<NewsCache *> *caches = [ctx executeFetchRequest:fetchRequest error:&error];
    [caches enumerateObjectsUsingBlock:^(NewsCache * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ctx deleteObject:obj];
    }];
    
    if ([ctx hasChanges]) {
        [ctx save:&error];
    }
    if (error) {
        NSLog(@"coredata delete news error:%@",error);
    }
}
@end

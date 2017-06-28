//
//  NewsCache+CoreDataProperties.h
//  
//
//  Created by M_Li on 2017/6/28.
//
//

#import "NewsCache+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsCache (CoreDataProperties)

+ (NSFetchRequest<NewsCache *> *)fetchRequest;

@property (nonatomic) int64_t ad_id;
@property (nullable, nonatomic, copy) NSString *commentNum;
@property (nullable, nonatomic, copy) NSString *elapseTime;
@property (nullable, nonatomic, copy) NSString *feedsType;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int64_t group_id;
@property (nullable, nonatomic, retain) NSArray *images;
@property (nonatomic) int16_t isBigPic;
@property (nonatomic) int64_t item_id;
@property (nullable, nonatomic, copy) NSString *log_extra;
@property (nonatomic) int16_t runtime;
@property (nonatomic) BOOL isSelect;

@property (nullable, nonatomic, copy) NSString *tag;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END

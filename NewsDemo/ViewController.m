//
//  ViewController.m
//  NewsDemo
//
//  Created by Seven on 2017/6/26.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "KMNewsModel.h"
#import "KMNewsAPI.h"
#import "WFNewsTextCell.h"
#import "WFImageTextNews.h"
#import "WFImagesNewsCell.h"
#import "WFBigImageNewsCell.h"
#import "WFVideoNewsCell.h"
#import "WFVideoTextCell.h"
#import "WFNewsADCell.h"
#import "WFNewsMovieCell.h"
#import "ShieldModule.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "NewsCoreDataManager.h"
#import "NewsCache+CoreDataClass.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *newsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self registerCell];
    [self newsData];
}
- (void)newsData{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.f",interval];
    
    
    
    NSDictionary *params = @{
                             @"platform" : @"ios",
                             @"userID" : @"80e5b8ddf0364b9c99ae2e44a4b6a60c",
                             @"ac" : @"mobile",
                             @"token" : @"77da5fa09d81441abc6b5d99852a922b",
                             @"load_status" : @2,
                             @"load_time" : @([time longLongValue]),
                             @"category" : @"__all__"
                             };
    [KMNewsAPI getNewsWithParam:params Success:^(id  _Nonnull response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            _newsArray = response;
            NSLog(@"网络获取数据result.count=%ld",_newsArray.count);
            NSMutableArray *cache = [self transformModelArrWithCacheArr:[[NewsCoreDataManager manager] getNewsCache]];
            if (cache && cache.count) {
                [_newsArray addObjectsFromArray:cache];
            }
            
//            [self saveContextWithNews:_newsArray];
            
            [[NewsCoreDataManager manager] insertCoreData:_newsArray];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"news error=%@",error);
        [self loadCacheData];
        
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"newsArray.count=%ld",_newsArray.count);
    return self.newsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KMNewsModel *model = self.newsArray[indexPath.row];
//    if ([model isKindOfClass:[NSString class]]) {
//        WFRefreshCell *refresh = [tableView dequeueReusableCellWithIdentifier:@"WFRefresh"];
//        return refresh;
//    }
    if (model.ad_id) {
//        [self uploadADWithModel:model andType:@"show"];
        if ([self.channel isEqualToString:@"video"]) {
            WFNewsADCell *ad = [tableView dequeueReusableCellWithIdentifier:@"WFNewsAD" forIndexPath:indexPath];
            ad.model = model;
            return ad;
        }
    }
    
    if ([model.feedsType isEqualToString:@"video"] && model.isBigPic == 1) {
        if ([self.channel isEqualToString:@"video"]) {
            WFNewsMovieCell *movie = [tableView dequeueReusableCellWithIdentifier:@"WFNewsMovie" forIndexPath:indexPath];
            movie.model = model;
            return movie;
        }
        WFVideoNewsCell *video = [tableView dequeueReusableCellWithIdentifier:@"videoNews" forIndexPath:indexPath];
        video.remove = ^(UITableViewCell *cell,CGPoint point){
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
        };
        video.model = model;
        return video;
    }else if ([model.feedsType isEqualToString:@"video"] && model.isBigPic == 0){
        WFVideoTextCell *videoText = [tableView dequeueReusableCellWithIdentifier:@"videoText" forIndexPath:indexPath];
        videoText.remove = ^(UITableViewCell *cell,CGPoint point){
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
        };
        videoText.model = model;
        return videoText;
    }else if ([model.feedsType isEqualToString:@"article"] && model.isBigPic == 1){
        WFBigImageNewsCell *bigImg = [tableView dequeueReusableCellWithIdentifier:@"bigImagenews" forIndexPath:indexPath];
        bigImg.channel = self.channel;
        bigImg.remove = ^(UITableViewCell *cell,CGPoint point){
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
        };
        bigImg.model = model;
        return bigImg;
    }else if ([model.feedsType isEqualToString:@"article"] && model.isBigPic == 0 && (model.images.count == 1 || model.images.count == 2)){
        WFImageTextNews *imageText = [tableView dequeueReusableCellWithIdentifier:@"imagesText" forIndexPath:indexPath];
        imageText.remove = ^(UITableViewCell *cell,CGPoint point){
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
        };
        imageText.model = model;
        return imageText;
    }else if ([model.feedsType isEqualToString:@"article"] && model.isBigPic == 0 && model.images.count == 3){
        WFImagesNewsCell *images = [tableView dequeueReusableCellWithIdentifier:@"imagesNews" forIndexPath:indexPath];
        images.remove = ^(UITableViewCell *cell,CGPoint point){
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
        };
        
        images.model = model;
        return images;
    }else{
        WFNewsTextCell *news = [tableView dequeueReusableCellWithIdentifier:@"newsText" forIndexPath:indexPath];
//        news.remove = ^(UITableViewCell *cell,CGPoint point){
//            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
//            [self removeAtIndexPath:indexPath showPoint:point upLoadModel:model];
//        };
        news.model = model;
        return news;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KMNewsModel *model = self.newsArray[indexPath.row];
    if ([model isKindOfClass:[NSString class]]) {
        return 40;
    }
    if (model.ad_id) {
        if ([self.channel isEqualToString:@"video"]) {
            return kWFScale(251);
        }
    }
    if ([model.feedsType isEqualToString:@"article"] && model.isBigPic == 0 && model.images.count == 3) {
        return [tableView fd_heightForCellWithIdentifier:@"imagesNews"  cacheByIndexPath:indexPath configuration:^(WFImagesNewsCell *cell) {
            cell.model = model;
        }];
    }else if (([model.feedsType isEqualToString:@"article"] || [model.feedsType isEqualToString:@"video"]) && model.isBigPic == 0 && (model.images.count == 1 || model.images.count == 2)){
        return 110;
    }else if (([model.feedsType isEqualToString:@"article"] || [model.feedsType isEqualToString:@"video"]) && model.isBigPic == 1 && model.images.count == 1){
        
        if ([self.channel isEqualToString:@"video"]) {
            return kWFScale(251);
        }
        if([model.feedsType isEqualToString:@"article"]){
            return [tableView fd_heightForCellWithIdentifier:@"bigImagenews"  cacheByIndexPath:indexPath configuration:^(WFBigImageNewsCell *cell) {
                cell.channel = self.channel;
                cell.model = model;
            }];
        }else{
            
            return [tableView fd_heightForCellWithIdentifier:@"videoNews"  cacheByIndexPath:indexPath configuration:^(WFVideoNewsCell *cell) {
                cell.model = model;
            }];
        }
        
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"newsText"  cacheByIndexPath:indexPath configuration:^(WFNewsTextCell *cell) {
            cell.model = model;
        }];
    }

}
#pragma mark - RegisterCell

- (void)registerCell{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 新闻cell 文字新闻cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFNewsTextCell class]) bundle:nil] forCellReuseIdentifier:@"newsText"];
    // 图文cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFImageTextNews class]) bundle:nil] forCellReuseIdentifier:@"imagesText"];
    // 多图cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFImagesNewsCell class]) bundle:nil] forCellReuseIdentifier:@"imagesNews"];
    // 大图Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFBigImageNewsCell class]) bundle:nil] forCellReuseIdentifier:@"bigImagenews"];
    // 大图视频Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFVideoNewsCell class]) bundle:nil] forCellReuseIdentifier:@"videoNews"];
    // 小图视频cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFVideoTextCell class]) bundle:nil] forCellReuseIdentifier:@"videoText"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFRefreshCell class]) bundle:nil] forCellReuseIdentifier:@"WFRefresh"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFNewsMovieCell class]) bundle:nil] forCellReuseIdentifier:@"WFNewsMovie"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFNewsADCell class]) bundle:nil] forCellReuseIdentifier:@"WFNewsAD"];
}
#pragma mark - cache newsArray
- (NSMutableArray *)transformModelArrWithCacheArr:(NSArray *)cacheArr{
    NSMutableArray *mArr = [NSMutableArray new];
    if (cacheArr && cacheArr.count) {
        
        for (NewsCache *cache in cacheArr) {
            NSLog(@"title=%@",cache.title);
            NSLog(@"image=%@",cache.images);
            KMNewsModel *model = [KMNewsModel new];
            model.title = cache.title;
            model.runtime = cache.runtime;
            model.from = cache.from;
            model.feedsType = cache.feedsType;
            if (cache.images) {
                model.images = cache.images;
            }
            model.url = cache.url;
            model.elapseTime = cache.elapseTime;
            model.runtime = cache.runtime;
            model.isBigPic = cache.isBigPic;
            model.ad_id = cache.ad_id;
            model.group_id = cache.group_id;
            model.item_id = cache.item_id;
            model.log_extra = cache.log_extra;
            model.tag = cache.tag;
            [mArr addObject:model];
        }
    }
    return mArr;
}
#pragma mark lazy
- (NSMutableArray *)newsArray{

    if (_newsArray == nil) {
        _newsArray = [NSMutableArray array];
    }
    return _newsArray;
}
#pragma mark - removeNews
- (void)removeAtIndexPath:(NSIndexPath *)indexPath showPoint:(CGPoint)point upLoadModel:(KMNewsModel *)model{
    [ShieldModule showShieldViewWithPoint:point completed:^{
        [self.newsArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    } canceled:nil];
}

#pragma mark save coredata
- (void)loadCacheData{
    NSMutableArray *mCache = [self transformModelArrWithCacheArr:[[NewsCoreDataManager manager] getNewsCache]];
    if (mCache && mCache.count > 0 && _newsArray.count == 0) {
        _newsArray = mCache;
        NSLog(@"count=%ld",_newsArray.count);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


//- (void)saveContextWithNews:(NSMutableArray *)news{
//    NSInteger index = 0;
//    [[NewsCoreDataManager manager] removeCache];
//    NSManagedObjectContext *ctx = [NewsCoreDataManager manager].mainContext;
//    for (KMNewsModel *model in news) {
//        if ([model isKindOfClass:[NSString class]]) {
//            continue;
//        }
//        index ++;
//        if (index > 20) {
//            break;
//        }
//        //Managed Object
//        NewsCache *cache = [NSEntityDescription insertNewObjectForEntityForName:@"NewsCache" inManagedObjectContext:ctx];
//        [cache insertWithModel:model];
//
//        if ([ctx hasChanges]) {
//            NSError *error;
//            if (![ctx save:&error]) {
//                NSLog(@"不能保存：%@",[error localizedDescription]);
//            }else{
//                [[NewsCoreDataManager manager] saveWithContext:ctx];
//            }
//        }
//    }
//}
@end

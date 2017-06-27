//
//  WFBigImageNewsCell.h
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KMNewsModel;

typedef void(^removeBlock)(UITableViewCell *cell,CGPoint point);
@interface WFBigImageNewsCell : UITableViewCell

@property(nonatomic,strong) KMNewsModel *model;
@property(nonatomic,copy) removeBlock remove;
@property(nonatomic,copy) NSString *channel;



@end

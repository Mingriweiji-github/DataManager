//
//  WFVideoTextCell.h
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMNewsModel.h"
typedef void(^removeBlock)(UITableViewCell *cell,CGPoint point);

@interface WFVideoTextCell : UITableViewCell

@property(nonatomic,strong) KMNewsModel *model;
@property(nonatomic,copy) removeBlock remove;


@end

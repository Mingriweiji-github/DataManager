//
//  WFImagesNewsCell.h
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMNewsModel.h"
@interface WFImagesNewsCell : UITableViewCell
typedef void(^removeBlock)(UITableViewCell *cell,CGPoint point);

@property(nonatomic,strong) KMNewsModel *model;

@property(nonatomic,copy) removeBlock remove;


@end

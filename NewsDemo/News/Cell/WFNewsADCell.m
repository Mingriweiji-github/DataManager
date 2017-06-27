//
//  WFNewsADCell.m
//  WangFan
//
//  Created by lyf on 2017/4/19.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "WFNewsADCell.h"

@interface WFNewsADCell ()
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UIButton *adDetail;

@end


@implementation WFNewsADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.adDetail.enabled = NO;
    self.title.font = [UIFont systemFontOfSize:kWFScale(16)];
    self.from.font = [UIFont systemFontOfSize:kWFScale(14)];

}

- (void)setModel:(KMNewsModel *)model{
    _model = model;
    self.title.text = model.title;
    self.from.text = model.from;
    if (model.images) {
        NSString *url = model.images.firstObject;
        if (url) {
            [self.adImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"big_zhanwei"]];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  WFNewsMovieCell.m
//  WangFan
//
//  Created by lyf on 2017/4/19.
//  Copyright © 2017年 ihangmei. All rights reserved.
//

#import "WFNewsMovieCell.h"

@interface WFNewsMovieCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *runTime;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *playTwice;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIView *gridentView;
@property(nonatomic,strong) CAGradientLayer *gradientLayer;

@end


@implementation WFNewsMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.title.font = [UIFont systemFontOfSize:kWFScale(16)];
    self.from.font = [UIFont systemFontOfSize:kWFScale(14)];
    self.playTwice.font = [UIFont systemFontOfSize:kWFScale(12)];
    self.comment.enabled = NO;
    self.comment.font = [UIFont systemFontOfSize:kWFScale(12)];
    self.playBtn.enabled = NO;
    
}


- (void)setModel:(KMNewsModel *)model{
    _model = model;
    self.title.text = model.title;
    if (model.from) {
        self.from.text = model.from;
    }
    if (model.video_watch_count > 0) {
        self.playTwice.text = [self transformPlaytwice:model.video_watch_count];
    }
    if ([model.commentNum integerValue] > 0) {
        self.comment.text = model.commentNum;
    }else{
        self.comment.text = @"";
    }
    if (model.images) {
        NSString *url = model.images.firstObject;
        if (url) {
            [self.newsImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"big_zhanwei"]];
        }
    }
    if (model.runtime) {
        self.runTime.text = [self timeFormatted:model.runtime];
    }
    
//    [self.contentView layoutIfNeeded];
}
- (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (NSString *)transformPlaytwice:(NSInteger)count{
    if (count < 10000) {
        return [NSString stringWithFormat:@"%ld次播放",count];
    }else{
        return [NSString stringWithFormat:@"%ld万次播放",count / 10000];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

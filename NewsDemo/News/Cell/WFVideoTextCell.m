//
//  WFVideoTextCell.m
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFVideoTextCell.h"

@interface WFVideoTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adWidthLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromLeading;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end


@implementation WFVideoTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layout.constant = (kWFScreenWidth - 30) / 3;
    self.removeBtn.enabled = NO;
    [self layoutIfNeeded];
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.backgroundColor = WFColorWithHex(0xf7f7f7);
    if (self.model.ad_id) {
        self.adWidthLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adWidthLayout.constant = 0;
        self.fromLeading.constant = 0;
    }
    self.newsTitle.font = [UIFont systemFontOfSize:kWFScale(16)];

}

- (void)setModel:(KMNewsModel *)model{
    _model = model;
    self.newsTitle.text = model.title;
    NSString *time = [KMUtils nowFromDateExchange:model.elapseTime];

    if ([model.commentNum integerValue]!= 0 || [model.commentNum isEqualToString:@""]) {
        if (model.elapseTime != nil) {
            _fromLabel.text = [NSString stringWithFormat:@"%@  %@评  %@",model.from,model.commentNum,time];
        }else{
            _fromLabel.text = [NSString stringWithFormat:@"%@ %@",model.from,model.commentNum];
        }
    }else{
        if (model.elapseTime != nil) {
            _fromLabel.text = [NSString stringWithFormat:@"%@  %@",model.from,time];
        }else{
            _fromLabel.text = [NSString stringWithFormat:@"%@",model.from];
        }
    }
    if (model.images) {
        NSString *url = model.images.firstObject;
        if (url) {
            [self.newsImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        }
    }
    if (model.runtime) {
        [self.playBtn setTitle:[self timeFormatted:model.runtime] forState:UIControlStateNormal];
    }
    if (self.model.ad_id) {
        self.adWidthLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adWidthLayout.constant = 0;
        self.fromLeading.constant = 0;
    }

    
}

- (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
} 


- (IBAction)removeNews:(id)sender {
    if (self.remove) {
//        self.remove(self);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.model.isSelect = YES;
        self.newsTitle.textColor = WFColorWithHex(0xB3B0AF);
    }else{
        if (self.model.isSelect) {
            self.newsTitle.textColor = WFColorWithHex(0xB3B0AF);
        }else{
            self.newsTitle.textColor = [UIColor blackColor];
        }
    }

    // Configure the view for the selected state
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =[touches anyObject];
    CGPoint point=[touch locationInView:self];
    
    if(CGRectContainsPoint(self.removeBtn.frame, point)){
        if (self.remove) {
            CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow];
            self.remove(self,point);
        }
        return;
    }
    if (CGRectContainsPoint(self.playBtn.frame, point)) {
        [super touchesBegan:touches withEvent:event];
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}


@end

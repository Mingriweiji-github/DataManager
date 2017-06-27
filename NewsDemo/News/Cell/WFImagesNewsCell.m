//
//  WFImagesNewsCell.m
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFImagesNewsCell.h"

@interface WFImagesNewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstNewsImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adWidthLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromLeading;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end

@implementation WFImagesNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.backgroundColor = WFColorWithHex(0xf0f0f0);
    self.removeBtn.enabled = NO;
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
    _newsTitle.text = model.title;
    NSString *time = [KMUtils nowFromDateExchange:model.elapseTime];
    
    if ([model.commentNum integerValue]!= 0 || [model.commentNum isEqualToString:@""]) {
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@评  %@",model.from,model.commentNum,time];
    }else{
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@",model.from,time];
    }
    if (model.images.count == 3) {
        NSString *firstUrl = model.images[0];
        if (firstUrl) {
            [self.firstNewsImg sd_setImageWithURL:[NSURL URLWithString:firstUrl] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        }
        NSString *secondUrl = model.images[1];
        if (secondUrl) {
            [self.secondImg sd_setImageWithURL:[NSURL URLWithString:secondUrl] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        }
        NSString *thirdUrl = model.images[2];
        if (thirdUrl) {
            [self.thirdImg sd_setImageWithURL:[NSURL URLWithString:thirdUrl] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        }
    }else{
        [self.firstNewsImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        [self.secondImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        [self.thirdImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
    }
    
    if (self.model.ad_id) {
        self.adWidthLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adWidthLayout.constant = 0;
        self.fromLeading.constant = 0;
    }
//    [self.contentView layoutIfNeeded];
}

- (IBAction)removeNews:(id)sender {
    if (self.remove) {
//        self.remove(self);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if(CGRectContainsPoint(self.removeBtn.frame, point)){
        if (self.remove) {
            CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow];
            self.remove(self,point);
        }
    }else{
        [super touchesBegan:touches withEvent:event];
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

@end

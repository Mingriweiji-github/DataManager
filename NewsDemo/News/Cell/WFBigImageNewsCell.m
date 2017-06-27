//
//  WFBigImageNewsCell.m
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFBigImageNewsCell.h"
#import "KMNewsModel.h"
@interface WFBigImageNewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adWidthLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromLeading;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aspectConst;

@end



@implementation WFBigImageNewsCell

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
    self.titleLabel.font = [UIFont systemFontOfSize:kWFScale(16)];
    if ([self.channel isEqualToString:@"美女"]) {
        self.aspectConst.constant = kWFScreenWidth * 0.75;
    }else{
        self.aspectConst.constant = 200;
    }
}

- (void)setModel:(KMNewsModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    NSString *time = [KMUtils nowFromDateExchange:model.elapseTime];
    if ([model.commentNum integerValue]!= 0 || [model.commentNum isEqualToString:@""]) {
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@评  %@",model.from,model.commentNum,time];
    }else{
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@",model.from,time];
    }
    if (model.images) {
        NSString *url = model.images.firstObject;
        if (url) {
            [self.newsImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"big_zhanwei"]];
        }
    }
    if (self.model.ad_id) {
        self.adWidthLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adWidthLayout.constant = 0;
        self.fromLeading.constant = 0;
    }
    
    if ([self.channel isEqualToString:@"美女"]) {
        self.aspectConst.constant = kWFScreenWidth * 0.7;
    }else{
        self.aspectConst.constant = 200;
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
        self.titleLabel.textColor = WFColorWithHex(0xB3B0AF);
    }else{
        if (self.model.isSelect) {
            self.titleLabel.textColor = WFColorWithHex(0xB3B0AF);
        }else{
            self.titleLabel.textColor = [UIColor blackColor];
        }
    }

    // Configure the view for the selected state
}

@end

//
//  WFNewsTextCell.m
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFNewsTextCell.h"

@interface WFNewsTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;


@end


@implementation WFNewsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *backView = [UIView new];
    backView.backgroundColor = WFColorWithHex(0xf0f0f0);
    self.selectedBackgroundView = backView;
    self.removeBtn.enabled = NO;
    self.newsTitle.font = [UIFont systemFontOfSize:kWFScale(16)];

}

- (IBAction)removeNews:(id)sender {
    if (self.remove) {
        CGPoint point;
        self.remove(self,point);
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

- (void)setModel:(KMNewsModel *)model{
    _model = model;
    _newsTitle.text = model.title;
    _fromLabel.text = model.from;
    NSString *time = [KMUtils nowFromDateExchange:model.elapseTime];
    if ([model.commentNum integerValue]!= 0 || [model.commentNum isEqualToString:@""]) {
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@评  %@",model.from,model.commentNum,time];
    }else{
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@",model.from,time];
    }
//    [self.contentView layoutIfNeeded];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.model.isSelect = YES;
        self.newsTitle.textColor = WFColorWithHex(0xB3B0AF);
    }else{
//        if (self.model.isSelect) {
//            self.newsTitle.textColor = WFColorWithHex(0xB3B0AF);
//        }else{
//            self.newsTitle.textColor = [UIColor blackColor];
//        }
    }

    // Configure the view for the selected state
}

@end

//
//  WFImageTextNews.m
//  WangFan
//
//  Created by lyf on 16/12/26.
//  Copyright © 2016年 ihangmei. All rights reserved.
//

#import "WFImageTextNews.h"

@interface WFImageTextNews ()

@property (weak, nonatomic) IBOutlet UILabel *newsTiltle;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromLeading;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@end



@implementation WFImageTextNews

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layout.constant = (kWFScreenWidth - 30) / 3;
    if (self.model.ad_id) {
        self.adLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adLayout.constant = 0;
        self.fromLeading.constant = 0;
    }
    [self layoutIfNeeded];
    UIView *backView = [UIView new];
    backView.backgroundColor = WFColorWithHex(0xf0f0f0);
    self.selectedBackgroundView = backView;
    self.removeBtn.enabled = NO;
    self.newsTiltle.font = [UIFont systemFontOfSize:kWFScale(16)];
}

- (void)setModel:(KMNewsModel *)model{
    _model = model;
    _newsTiltle.text = model.title;
    
    if ([model.commentNum integerValue]!= 0 || [model.commentNum isEqualToString:@""]) {
        _fromLabel.text = [NSString stringWithFormat:@"%@  %@评",model.from,model.commentNum];
    }else{
        _fromLabel.text = [NSString stringWithFormat:@"%@",model.from];
    }
    if (model.images) {
        NSString *url = model.images.firstObject;
        if (url) {
            [self.newsImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"news_zhanwei"]];
        }
        
    }
    if (self.model.ad_id) {
        self.adLayout.constant = 29;
        self.fromLeading.constant = 5;
    }else{
        self.adLayout.constant = 0;
        self.fromLeading.constant = 0;
    }
    
}

- (IBAction)removeNews:(id)sender {
    if (self.remove) {
//        self.remove(self);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =[touches anyObject];
    CGPoint point = [touch locationInView:self];
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
        self.newsTiltle.textColor = WFColorWithHex(0xB3B0AF);
    }else{
        if (self.model.isSelect) {
            self.newsTiltle.textColor = WFColorWithHex(0xB3B0AF);
        }else{
            self.newsTiltle.textColor = [UIColor blackColor];
        }
    }
    // Configure the view for the selected state
}

@end

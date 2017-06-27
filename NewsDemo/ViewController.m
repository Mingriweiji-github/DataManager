//
//  ViewController.m
//  NewsDemo
//
//  Created by Seven on 2017/6/26.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "KMNewsAPI.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self newsData];
}


- (void)newsData{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.f",interval];
    
    NSDictionary *params = @{
                             @"platform" : @"ios",
                             @"userID" : @"80e5b8ddf0364b9c99ae2e44a4b6a60c",
                             @"ac" : @"mobile",
                             @"token" : @"77da5fa09d81441abc6b5d99852a922b",
                             @"load_status" : @2,
                             @"load_time" : @([time longLongValue]),
                             @"category" : @"__all__"
                             };
    [KMNewsAPI getNewsWithParam:params Success:^(id  _Nonnull response) {
        
        NSLog(@"response=%@",response);
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"news error=%@",error);
    }];

}


@end

//
//  VC2View.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/24.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "VC2View.h"


@interface VC2View()
@property (nonatomic) NSArray * arr;
@property (nonatomic) NSString * str;
@end

@implementation VC2View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnClick {
    
}

- (NSArray *)arr {
    return @[@"1",@"2",@"3",@"4"];
}

- (NSString *)str {
    return @"vc2---str";
}
@end

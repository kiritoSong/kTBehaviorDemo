//
//  ViewController.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "ViewController.h"
#import "KTBehaviorDataManager.h"

@interface ViewController ()
@property (nonatomic) NSString * vc1Str;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.vc1Str = @"我是vc1的参数";
    [self upLoadPic];

}



- (void)upLoadPic {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do the work in background
        KTBehaviorData * data = [KTBehaviorData new];
        data.op_type = @"3";
        data.page_code = @"ViewController";
        data.event_code = @"upLoadPic";
        data.start_time =[KTBehaviorData getNowTimeTimestamp];
        
        [NSThread sleepForTimeInterval:5];
   
        data.end_time = [KTBehaviorData getNowTimeTimestamp];
        
        [[KTBehaviorDataManager sharedManager] pushKTBehaviorDataWithModel:data];
    });

    
}

- (IBAction)pushEvent:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

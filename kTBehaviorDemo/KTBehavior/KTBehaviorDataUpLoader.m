//
//  KTBehaviorDataUpLoader.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/23.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "KTBehaviorDataUpLoader.h"
#import "KTBehaviorDataCache.h"

@implementation KTBehaviorDataUpLoader
+ (void)load {
    //程序启动、上报记录
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [KTBehaviorDataUpLoader upLoadData];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}


+ (void)upLoadData {
    id data = [KTBehaviorDataCache readWithStorageType:kBehaviorLogData];
    if (data) {
        //上报
        NSLog(@"程序启动、上报记录：%@",data);
        [KTBehaviorDataCache removeDataWithStorageType:kBehaviorLogData];
    }
}
@end

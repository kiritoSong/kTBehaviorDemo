//
//  KTBehaviorDataManager.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "KTBehaviorDataManager.h"
#import "KTBehaviorDataCache.h"
#import "NSObject+KTAspectsHook.h"

@interface KTBehaviorDataManager ()
@property (nonatomic, strong) KTBehaviorUpLoadData *data;
@property (nonatomic, strong) NSMutableDictionary *startTimeDic;
@end

@implementation KTBehaviorDataManager
+ (instancetype)sharedManager {
    static id sharedInstaller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstaller = [[self alloc] init];
    });
    return sharedInstaller;
}


+ (void)load {
    
    //杀死程序 (但当程序位于后台呗杀死不执行)
    __block id observer1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"杀死程序---将数据写入本地");
        //将数据写入本地
        [[KTBehaviorDataManager sharedManager] writeBehaviorData];

        [[NSNotificationCenter defaultCenter] removeObserver:observer1];
    }];
    
    
    //程序切换至后台
    __block id observer2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"程序切换至后台---将数据写入本地");
        //将数据写入本地
        [[KTBehaviorDataManager sharedManager] writeBehaviorData];
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer2];
    }];
}

#pragma mark - private method
- (void)writeBehaviorData {
    
    [KTBehaviorDataCache writeWithData:[self.data dicValue] storageType:kBehaviorLogData];
}



- (void)pushKTBehaviorDataWithModel:(KTBehaviorData *)model {
    
    //线程锁、保证数据完整性
    @synchronized(self) {
        [self.data.datas addObject:model];
        NSLog(@"打点记录::::%@",[NSObject properties_apsWithObj:model]);
    }
    
}


- (void)pushKTBehaviorDataWithPageId:(NSString *)pageId time:(NSString *)time {
    if ([self.startTimeDic.allKeys containsObject:pageId]) {
        NSString *start = [self.startTimeDic valueForKey:pageId];
        [self pushKTBehaviorDataWithPageId:pageId start:start end:[KTBehaviorData getNowTimeTimestamp]];
        [self.startTimeDic removeObjectForKey:pageId];
    } else {
        [self.startTimeDic setValue:[KTBehaviorData getNowTimeTimestamp] forKey:pageId];
    }
}

- (void)pushKTBehaviorDataWithPageId:(NSString *)pageId start:(NSString *)startTime end:(NSString *)endTime {
    
    KTBehaviorData * data = [KTBehaviorData new];
    data.op_type = @"2";
    data.page_code = pageId;
    data.start_time = startTime;
    data.end_time = endTime;
    [[KTBehaviorDataManager sharedManager] pushKTBehaviorDataWithModel:data];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]];
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"VC%@---进入%@---离开%@---间隔%0.0f秒",data.page_code,data.start_time,data.end_time,seconds/1000.0f);
}




#pragma mark - getter
- (KTBehaviorUpLoadData *)data {
    if (_data == nil) {
        _data = [[KTBehaviorUpLoadData alloc] init];
        _data.app_type = @"1";
        _data.app_version = @"版本";
        _data.device_id = @"设备号";
        _data.os_type = @"1";
        _data.os_version = [[UIDevice currentDevice] systemVersion];
        _data.user_id = @"16000";
        _data.login_account = @"135xxxxxxx";
        _data.screen = @"分辨率";
        _data.datas = (NSMutableArray <KTBehaviorData *>*)[NSMutableArray array];
        NSDictionary *datas = [KTBehaviorDataCache readWithStorageType:kBehaviorLogData];
        for (NSDictionary *temp in datas[@"datas"]) {
            //字典转模型、懒得引库了。
//            KTBehaviorData *model = [[KTBehaviorData ne] initWithDictionary:temp error:nil];
            //假数据
            KTBehaviorData *model = [KTBehaviorData new];
            model.op_type = @"旧数据重载";
            [_data.datas addObject:model];
        }
  
        NSLog(@"数据初始化完成---%ld",_data.datas.count);
    }
    return _data;
}


- (NSMutableDictionary *)startTimeDic {
    if (!_startTimeDic) {
        _startTimeDic = [NSMutableDictionary new];
    }
    return _startTimeDic;
}
@end

//
//  KTBehaviorDataCache.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "KTBehaviorDataCache.h"
#import "KTBehaviorDataManager.h"


NSString *const FileName = @"LocalStorage1";
NSString *const kBehaviorLogData = @"kBehaviorLogData";


@interface KTBehaviorDataCache ()
@property (nonatomic, strong) NSString *storagePath;
@end


@implementation KTBehaviorDataCache


+ (instancetype)sharedManager {
    static id sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


//写入
+ (BOOL)writeWithData:(id)data storageType:(NSString *)type {
    
    KTBehaviorDataCache *mamager = [KTBehaviorDataCache sharedManager];
    NSString *path = [mamager.storagePath stringByAppendingPathComponent:type];
    NSData *temp = [NSKeyedArchiver archivedDataWithRootObject:data];
    return [NSKeyedArchiver archiveRootObject:temp toFile:path];
    
}

//读取
+ (id)readWithStorageType:(NSString *)type {
    
    KTBehaviorDataCache *mamager = [KTBehaviorDataCache sharedManager];
    NSString *path = [mamager.storagePath stringByAppendingPathComponent:type];
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

//移除
+ (BOOL)removeDataWithStorageType:(NSString *)type {
    
    KTBehaviorDataCache *mamager = [KTBehaviorDataCache sharedManager];
    NSString *path = [mamager.storagePath stringByAppendingPathComponent:type];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


#pragma mark - getter
- (NSString *)storagePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:FileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

@end

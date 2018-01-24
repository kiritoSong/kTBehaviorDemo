//
//  KTBehaviorDataCache.h
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 *  存储模块
 */

UIKIT_EXTERN NSString *const kBehaviorLogData;


@interface KTBehaviorDataCache : NSObject


+ (instancetype)sharedManager;

//写入
+ (BOOL)writeWithData:(id)data storageType:(NSString *)type;

//读取
+ (id)readWithStorageType:(NSString *)type;

//移除
+ (BOOL)removeDataWithStorageType:(NSString *)type;
@end

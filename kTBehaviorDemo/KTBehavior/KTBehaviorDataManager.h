//
//  KTBehaviorDataManager.h
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KTBehaviorData.h"

/*
 * 打点记录模块
 */

@interface KTBehaviorDataManager : NSObject
+ (instancetype)sharedManager;

//代码埋点
- (void)pushKTBehaviorDataWithModel:(KTBehaviorData *)model;




//页面停留
- (void)pushKTBehaviorDataWithPageId:(NSString *)pageId time:(NSString *)time;

- (void)pushKTBehaviorDataWithPageId:(NSString *)pageId start:(NSString *)startTime end:(NSString *)endTime;

@end

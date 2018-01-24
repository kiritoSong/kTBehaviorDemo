//
//  KTBehaviorData.h
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/22.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 * 数据存储模型
 */

@interface KTBehaviorData : NSObject
@property (nonatomic, strong) NSString *op_type; // 1点击事件 2页面事件 3IO操作
@property (nonatomic, strong) NSString *page_code; // 页面Id
@property (nonatomic, strong) NSString *event_code; // 事件Id
@property (nonatomic, strong) NSDictionary *object_dic; // 内容Id
@property (nonatomic, strong) NSString *op_time; // 点击事件操作时间
@property (nonatomic, strong) NSString *start_time; // 页面事件开始时间
@property (nonatomic, strong) NSString *end_time; // 页面事件结束时间

- (NSDictionary *)dicValue;
+ (NSString *)getNowTimeTimestamp;
@end


@interface KTBehaviorUpLoadData : NSObject
@property (nonatomic, strong) NSString *app_type; //
@property (nonatomic, strong) NSString *app_version;
@property (nonatomic, strong) NSString *os_type; // 1苹果iOS
@property (nonatomic, strong) NSString *os_version; // 系统版本
@property (nonatomic, strong) NSString *device_id; // 设备id
@property (nonatomic, strong) NSString *user_id; // 用户id
@property (nonatomic, strong) NSString *login_account; // 用户账号
@property (nonatomic, strong) NSString *screen; // 屏幕分辨率...
@property (nonatomic, strong) NSMutableArray <KTBehaviorData *>*datas;


//不要在意里面的实现、就是模型转字典。我懒得引库所以自己写了而已
- (NSDictionary *)dicValue;
@end

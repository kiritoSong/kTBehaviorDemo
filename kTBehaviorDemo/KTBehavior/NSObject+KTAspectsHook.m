//
//  NSObject+KTAspectsHook.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/24.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "NSObject+KTAspectsHook.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Aspects.h"
#import "KTBehaviorData.h"
#import "KTBehaviorDataManager.h"



static NSString * const kBehaviorEvents             = @"BehaviorEvents";
static NSString * const kBehaviorEventSelectorName  = @"BehaviorEventSelectorName";//方法名
static NSString * const kBehaviorParameter           = @"BehaviorParameter"; // 参数
static NSString * const kBehaviorEventId            = @"BehaviorEventId"; // 事件Id
static NSString * const kBehaviorPageId             = @"BehaviorPageId"; // 页面Id
static NSString * const kBehaviorType          = @"BehaviorType"; // 页面Id


@implementation NSObject (KTAspectsHook)

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [NSObject setupBehaviorObj];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

#pragma mark - private method
//hook所有需要打点的对象方法
+ (void)setupBehaviorObj {
    
    
    NSDictionary *behaviorPlist = [self getBehaviorEvents];
    
    for (NSString * className in behaviorPlist) {
        //需要hook的Class
        Class clazz = NSClassFromString(className);
        
        //对应Class需要hook的方法名
        NSDictionary *events = behaviorPlist[className];
        
        if (events[kBehaviorEvents]) {
            //事件数组
            for (NSDictionary *event in events[kBehaviorEvents]) {
                
                //具体事件方法
                SEL selector = NSSelectorFromString(event[kBehaviorEventSelectorName]);
                
                [clazz aspect_hookSelector:selector withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    
                    //获取参数
                    NSMutableDictionary * parameterDic = [NSMutableDictionary new];
                    if (event[kBehaviorParameter]) {
                        
                        NSDictionary * dic = [NSObject properties_apsWithObj:[aspectInfo instance]];
                        for (NSString * parameterStr in event[kBehaviorParameter]) {
                            
                            if ([dic valueForKey:parameterStr]) {
                                [parameterDic setValue:[dic valueForKey:parameterStr] forKey:parameterStr];
                            }
                        }
                    }
                    
                    KTBehaviorData * data = [KTBehaviorData new];
                    data.op_time = [KTBehaviorData getNowTimeTimestamp];
                    data.event_code = event[kBehaviorEventId];
                    data.object_dic = parameterDic;
                    data.page_code = event[kBehaviorPageId];
                    data.op_type = event[kBehaviorType];
                    
                    [[KTBehaviorDataManager sharedManager]pushKTBehaviorDataWithModel:data];
                    
                    
                } error:NULL];
                
            }
        }
    }

}




+ (NSDictionary *)getBehaviorEvents {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"KtBehaviorDemo" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}



+ (NSDictionary *)properties_apsWithObj:(id)obj

{
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    
    for (i = 0; i<outCount; i++)
        
    {
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        
    }
    
    free(properties);
    
    return props;
    
}

@end

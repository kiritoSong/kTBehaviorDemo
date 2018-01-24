//
//  NSObject+KTAspectsHook.h
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/24.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KTAspectsHook)

//不要在意里面的实现、就是模型转字典。我懒得引库所以自己写了而已
+ (NSDictionary *)properties_apsWithObj:(id)obj;
@end

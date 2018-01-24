//
//  UIViewController+KTHook.m
//  kTBehaviorDemo
//
//  Created by 刘嵩野 on 2018/1/23.
//  Copyright © 2018年 刘嵩野. All rights reserved.
//

#import "UIViewController+KTHook.h"
#import "KTHook.h"
#import "KTBehaviorDataManager.h"
#import "KTBehaviorData.h"


@implementation UIViewController (KTHook)


//这两个swizzle只是为了演示用
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector1 = @selector(viewWillAppear:);
        SEL swizzledSelector1 = @selector(kt_viewWillAppear:);
        [KTHook swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(kt_viewWillDisappear:);
        [KTHook swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
    });
}
#pragma mark - Method Swizzling
- (void)kt_viewWillAppear:(BOOL)animated
{

    [[KTBehaviorDataManager sharedManager]pushKTBehaviorDataWithPageId:NSStringFromClass([self class]) time:[KTBehaviorData getNowTimeTimestamp]];
    [self kt_viewWillAppear:animated];
}


- (void)kt_viewWillDisappear:(BOOL)animated
{
  
    [[KTBehaviorDataManager sharedManager]pushKTBehaviorDataWithPageId:NSStringFromClass([self class]) time:[KTBehaviorData getNowTimeTimestamp]];
    [self kt_viewWillDisappear:animated];
}


@end

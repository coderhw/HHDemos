//
//  TTPerson.m
//  TTProject
//
//  Created by Evan on 16/8/6.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "HHPerson.h"
#import <objc/message.h>

@implementation HHPerson

+ (instancetype)person {
    
    HHPerson *person = [[HHPerson alloc] init];
    return person;
}

void studyEngilsh(id self, SEL _cmd) {
    NSLog(@"动态添加了一个学习英语的方法");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == NSSelectorFromString(@"studyEngilsh")) {
        // 注意:这里需要强转成IMP类型
        class_addMethod(self, sel, (IMP)studyEngilsh, "v@:");
        return YES;
    }
    // 先恢复, 不然会覆盖系统的方法
    return [super resolveInstanceMethod:sel];
}



@end

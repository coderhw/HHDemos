//
//  HHPerson+Test.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/9/21.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHPerson+Test.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation HHPerson (Test)

const void *HHAgeKey = &HHAgeKey;


- (void)setAge:(NSString *)age {
    objc_setAssociatedObject(self, HHAgeKey, age, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)age {
    return objc_getAssociatedObject(self, HHAgeKey);
}

@end

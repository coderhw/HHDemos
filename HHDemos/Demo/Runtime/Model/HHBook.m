//
//  HHBook.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/3/22.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHBook.h"

@implementation HHBook

+ (void)load {
    NSLog(@"--load");
}

+ (void)initialize
{
    if (self == [HHBook class]) {
        NSLog(@"HHBook initialize");
    }
}

- (void)readBook {
    NSLog(@"%s", __func__);
}

@end

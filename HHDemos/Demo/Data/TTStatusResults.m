//
//  statusResult.m
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTStatusResults.h"

@implementation TTStatusResults

// 映射数组里面需要装什么数据模型
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"statuses" : @"TTStatus",
             @"ads" : @"TTAd"
             };
}

@end


//
//  NSArray+Util.m
//  MeiFang
//
//  Created by Evan on 2016/12/22.
//  Copyright © 2016年 Vanke.com All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)

+ (NSArray *)subArrayWithArray:(NSArray *)desArray Index:(NSInteger)index {
    if(!desArray.count) return nil;
    
    if(index > desArray.count) {
        index = desArray.count;
    }
    
    NSMutableArray *results = [NSMutableArray array];
    for(int i = 0; i < index; i++) {
        [results addObject:[desArray objectAtIndex:i]];
    }
    return results;
}


+ (NSArray *)arrayGetSubArray:(NSArray *)array withKey:(NSString *)key {
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (id obj in array) {
        if([obj isKindOfClass:[NSDictionary class]]){
            id value = [obj objectForKey:key];
            if(value){
                [tempArr addObject:value];
            }
        }
    }
    return tempArr;
}


+ (NSArray *)getValueFromDicWithArrayKey:(NSString *)arrayKey otherKey:(NSString *)subDicKey dic:(NSDictionary *)dic{
    
    __block NSMutableArray *containArray = [NSMutableArray array];
    NSArray *subArray = dic[arrayKey];
    [subArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSDictionary class]]){
            NSString *value = [NSString stringWithFormat:@"%@", obj[subDicKey]];
            [containArray addObject:value];
        }
    }];
    
    return containArray;
}

+ (NSArray *)getDicsFromArray:(NSArray *)datas withValue:(NSArray *)values key:(NSString *)key{
    
    if(!values.count || !datas.count) return nil;
    __block NSMutableArray *tempArray = [NSMutableArray array];
    [values enumerateObjectsUsingBlock:^(NSString  *value, NSUInteger idx, BOOL * _Nonnull stop) {
        [datas enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isKindOfClass:[NSDictionary class]]){
                if([obj[key] integerValue] == [value integerValue]){
                    [tempArray addObject:obj];
                }
            }
        }];
    }];
    
    return tempArray;
}

//中文数组排序
+ (NSArray *)chineseAscending:(NSArray *)sortArray
{
    NSComparator cmptr = ^(id obj1, id obj2){
        
        return [obj1 localizedCompare:obj2];
        
        return (NSComparisonResult)NSOrderedSame;
    };
    
    return [sortArray sortedArrayUsingComparator:cmptr];
}

//+ (NSArray *)pinYinAscending:(NSArray *)sortArray{
//    
//    NSComparator cmptr = ^(id obj1, id obj2){
//        
//        if ([obj1 isKindOfClass:[MFContact class]]) {
//            MFContact *c_1 = obj1;
//            MFContact *c_2 = obj2;
//            return [c_1.fullName localizedCompare:c_2.fullName];
//            
//        }
//        
//        return [dicGetString(obj1, @"name") localizedCompare:dicGetString(obj2, @"name")];
//        
//        //        return (NSComparisonResult)NSOrderedSame;
//    };
//    
//    return [sortArray sortedArrayUsingComparator:cmptr];
//    
//}

@end

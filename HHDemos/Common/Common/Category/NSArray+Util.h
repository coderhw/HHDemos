//
//  NSArray+Util.h
//  MeiFang
//
//  Created by Evan on 2016/12/22.
//  Copyright © 2016年 Vanke.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Util)
/**
 获取数组的下表0到count范围的子数组
 
 @param desArray 目标数组
 @param index 下标
 @return 返回结果
 */
+ (NSArray *)subArrayWithArray:(NSArray *)desArray Index:(NSInteger)index;


/**
 通过Key获取数组内部字典中相同key的值，并返回一个数组容器

 @param array 数组
 @param key key
 */
+ (NSArray *)arrayGetSubArray:(NSArray *)array withKey:(NSString *)key;

/**
 从字典中的数组中的字典对象提取数据
 
 @param arrayKey  获取子数组对应的Key
 @param subDicKey 获取子字典value对应的key
 @param dic 目标数组
 @return 返回数组
 */

+ (NSArray *)getValueFromDicWithArrayKey:(NSString *)arrayKey otherKey:(NSString *)subDicKey dic:(NSDictionary *)dic;



/**
 从数组中获取字典数组

 @param datas 目标数组
 @param values 对应keys(通过keys里面的key筛选目标字典数组)
 @param key 要筛选的key
 @return 返回筛选后的字典数组
 */
+ (NSArray *)getDicsFromArray:(NSArray *)datas withValue:(NSArray *)values key:(NSString *)key;


//中文数组排序
+ (NSArray *)chineseAscending:(NSArray *)sortArray;

//根据拼音排序分组
//+ (NSArray *)pinYinAscending:(NSArray *)sortArray;

@end

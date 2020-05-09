//
//  BLCheckUtility.h
//  MeiFang
//
//  Created by ChenBaolin on 2016/2/14.
//  Copyright © 2017年 Vanke.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKCheckUtility : NSObject

//--------------------------------------------------------------------------------------
// 检查对象是否有数据
/***********************************************************
 * 方法名称： checkObjectAvailable:
 * 功能描述： 检查数据类型的有效性（是否有内容）
 * 输入参数：
 object，所要检查的数据
 * 返 回 值： NO表示无效，YES表示有效
 * 其它说明： 检查数据类型如：NSValue、NSNumber、NSString、NSData、NSArray、NSDictionary
 ***********************************************************/
+ (BOOL)checkObjectAvailable:(id)object;

// 检测中国身份证
/***********************************************************
 * 方法名称： checkIdNo:
 * 功能描述： 检查身份证号码有效性
 * 输入参数：
 identity，需要检测的身份证号码
 * 返 回 值： NO表示无效，YES表示有效
 * 其它说明： 只针对中国的身份证
 ***********************************************************/
+ (BOOL)checkIdNo:(NSString *)identity;


// 检测中国手机号，type:1移动、2联通、3电信、其他的检测是否满足11位
/***********************************************************
 * 方法名称： checkMobileNo: forType:
 * 功能描述： 检查手机号码有效性
 * 输入参数：
 phone，需要检测的手机号码
 type，需要检测的手机号码类型，
 * 返 回 值： NO表示无效，YES表示有效
 * 其它说明： 只针对中国的手机号码，type:1移动、2联通、3电信、其他的检测是否满足11位
 ***********************************************************/
+ (BOOL)checkMobileNo:(NSString *)phone forType:(NSInteger)type;

//11位 1开头
+ (BOOL)checkMobileNo:(NSString *)phone;


//--------------------------------------------------------------------------------------
// 获取星期
/***********************************************************
 * 方法名称： getWeekDayFromDateString: formatter:
 * 功能描述： 在一定格式的日期字符串中返回中文格式的星期
 * 输入参数：
 datetime，日期字符串；
 format，日期字符串的格式，如@"yyyy-MM-dd HH：mm：ss"；
 * 返 回 值： 中文星期，如@"星期一"
 * 其它说明： 无
 ***********************************************************/
+ (NSString *)getWeekDayFromDateString:(NSString *)datetime formatter:(NSString *)format;
+ (NSString *)getWeekDayFromDate:(NSDate *)date;

// NSString转换NSDate
/***********************************************************
 * 方法名称： stringToDate: formatter:
 * 功能描述： 字符串日期转为NSDate
 * 输入参数：
 datetime，日期字符串；
 format，日期字符串的格式，如@"yyyy-MM-dd HH：mm：ss"；
 * 返 回 值： NSDate数据类型的日期
 * 其它说明： 无
 ***********************************************************/
+ (NSDate *)stringToDate:(NSString *)datetime formatter:(NSString *)format;


// NSDate转换NSString
/***********************************************************
 * 方法名称： dateToString: formatter:
 * 功能描述： NSDate数据类型的日期转为字符串日期
 * 输入参数：
 datetime，NSDate数据类型的日期；
 format，日期字符串的格式，如@"yyyy-MM-dd HH：mm：ss"；
 * 返 回 值： 字符串日期
 * 其它说明： 无
 ***********************************************************/
+ (NSString *)dateToString:(NSDate *)datetime formatter:(NSString *)format;


// 日期格式转换
/***********************************************************
 * 方法名称： changeDate: fromFormat: toFormat:
 * 功能描述： 把字符串日期转换格式
 * 输入参数：
 dateStr，需要转换的字符串日期
 fromFormat，当前日期字符串的格式，如@"yyyy-MM-dd HH：mm：ss"；
 toFormat，转换后日期字符串的格式，如@"yyyy-MM-dd HH：mm：ss"；
 * 返 回 值： 字符串日期
 * 其它说明： 无
 ***********************************************************/
+ (NSString *)changeDate:(NSString *)dateStr fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

// 字典取字符串
/***********************************************************
 * 方法名称： getStringFromDict: withKey:
 * 功能描述： 从字典中取出字符串格式
 * 输入参数：
 dict，字典
 key，字典中的key
 * 返 回 值： 字符串
 * 其它说明： 无
 ***********************************************************/

+ (NSString *)getStringFromDict:(NSDictionary *)dict withKey:(id)key;

// 获取货币千分位格式
/***********************************************************
 * 方法名称： getCurrencyFormatter:
 * 功能描述： 将数字转换成货币格式
 * 输入参数：
 obj，数字
 * 返 回 值： 字符串
 * 其它说明： 无
 ***********************************************************/

+ (NSString *)getCurrencyFormatter:(id )obj;

// 获取货币千分位格式
/***********************************************************
 * 方法名称： getRMBCurrencyFormatter:
 * 功能描述： 将数字转换成人民币格式
 * 输入参数：
 obj，数字
 * 返 回 值： 字符串
 * 其它说明： 无
 ***********************************************************/
+ (NSString *)getRMBCurrencyFormatter:(id )obj;


@end

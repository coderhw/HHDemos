//
//  NSString+Util.h
//  ZKFramework
//
//  Created by kyori.hu on 12-10-10.
//  Copyright (c) 2012 Vanke.com All rights reserved.
//

@interface NSString (Trim)

//去掉空格
- (NSString *)trim;

@end


@interface NSString (Util)
+ (NSString *)uuid;
- (NSString *)md5String;
- (NSString *)base64String; //
- (NSString *)urlencodeString;
- (NSString *)chineseNumString;
- (NSString *)fliterSpace;
- (NSString *)replaceSpace;
- (NSString *)sha_1String;
- (NSString *)phonesReplaceNotNumCharacters;
+ (NSString *)getShowNumberFromCnt:(NSString *)cnt;
+ (instancetype)stringFromDeviceToken:(NSData *)token;
+ (instancetype)versionString;
+ (instancetype)displayName;
+ (instancetype)dateStringFromTimeStamp:(unsigned long)timeStamp;
+ (instancetype)nowIfZeroDateStringFromTimeStamp:(unsigned long)timeStamp;
+ (NSString *)formatringStirng:(NSString *)amount;

+ (BOOL)isNum:(NSString *)checkedNumString;


/**
 从数组中获取字典的某一个key的对应的value相等的另一个key的value

 @param key 通过key找到对应的字典
 @param valueKey 与key对应的value，如果匹配则取给字典另一个key对应的value返回
 @param resultvalue 通过他获取最后需要的value
 @param values 数组
 @return 结果
 */
+ (NSString *)getValueFromSubDictionaryWithKeyIndex:(NSString *)key
                                           ValueKey:(NSString *)valueKey
                                        resultvalue:(NSString *)resultvalue values:(NSArray *)values;

//字符串+
+ (NSString *)addV1:(NSString *)v1 v2:(NSString *)v2;

//字符串-
+ (NSString *)subV1:(NSString *)v1 v2:(NSString *)v2;

//字符串乘
+ (NSString *)mulV1:(NSString *)v1 v2:(NSString *)v2;

//字符串除
+ (NSString *)divV1:(NSString *)v1 v2:(NSString *)v2;

// 简单只包含 + - 的计算
+ (NSString *)calcSimpleFormula:(NSString *)formula;

// 获取字符串中的后置数字
+ (NSString *)lastNumberWithString:(NSString *)str;

// 获取字符串中的前置数字
+ (NSString *)firstNumberWithString:(NSString *)str;

// 包含 * / 的计算
+ (NSString *)calcNormalFormula:(NSString *)formula;

// 复杂计算公式计算,接口主方法
+ (NSString *)calcComplexFormulaString:(NSString *)formula;

//金额添加 千位分隔符号
+ (NSString *)formatCurrency:(NSString *)string;

+ (NSMutableAttributedString *)addUnderLineString:(NSString *)string;

@end

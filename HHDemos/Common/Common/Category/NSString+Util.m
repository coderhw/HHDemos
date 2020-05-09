//
//  NSString+Util.m
//  ZKFramework
//
//  Created by kyori.hu on 12-10-10.
//  Copyright (c) 2012 Vanke.com All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSString+Util.h"
#import "base64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



static NSString *kuuid = @"uuid";
@implementation NSString (Trim)

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end


@implementation NSString (Util)

- (NSString *)base64String {
	const char *szUtf8 = [self UTF8String];
	if ( szUtf8 ) {
		char szBase64[2048];
		memset( szBase64, 0, sizeof(szBase64) );
		Base64Encode( szBase64, (const unsigned char*)szUtf8, strlen(szUtf8) );
		NSString *strBase64 = [NSString stringWithUTF8String:szBase64];
		return strBase64;
	}
	return nil;
}

+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

- (NSString *)md5String
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5([data bytes], [data length], result);
	return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]] lowercaseString];
}


- (NSString *)urlencodeString
{
	NSString *strUrlencode =  [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	strUrlencode = [strUrlencode stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
	strUrlencode = [strUrlencode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
	return strUrlencode;
}

- (NSString *)chineseNumString
{
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
     formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
     formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
     
     NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt: [self intValue]]];
     
     return string;    
}

- (NSString *)fliterSpace
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
}

- (NSString *)replaceSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)sha_1String
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)phonesReplaceNotNumCharacters {
    if (!self) {
        return @"";
    }
    if (self.length == 0) {
        return @"";
    }
    NSString *string = [self stringByReplacingOccurrencesOfString:@"；" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"，" withString:@""];
    return string;
}

+ (NSString *)getShowNumberFromCnt:(NSString *)cnt {
    if (!cnt) {
        return @"0";
    }
    if ([cnt isKindOfClass:[NSString class]]) {
        if ([cnt trim].length == 0) {
            return @"0";
        }
    }
    int c = [cnt intValue];
    if (c > 0) {
        return [NSString stringWithFormat:@"%@",cnt];
    }
    return @"0";
}

+ (instancetype)stringFromDeviceToken:(NSData *)token
{
    NSString *tokenString;
    
    if (token) {
        tokenString = [[[[token description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return tokenString;
}
+ (instancetype)versionString {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

}

+ (instancetype)displayName {
    return [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleDisplayName"];
}

+ (instancetype)dateStringFromTimeStamp:(unsigned long)timeStamp {
    if (timeStamp == 0) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *time = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp/1000]];
    return time;
}

+ (instancetype)nowIfZeroDateStringFromTimeStamp:(unsigned long)timeStamp {
    NSDate *date ;
    if (timeStamp == 0) {
        date = [NSDate date];
    } else {
        date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}

+ (NSString *)formatringStirng:(NSString *)amount {
    
    NSString *formatString = nil;
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,##0";
    formatString = [moneyFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithString:amount]];
    return formatString;
}

+ (NSString *)getValueFromSubDictionaryWithKeyIndex:(NSString *)key
                                           ValueKey:(NSString *)valueKey
                                        resultvalue:(NSString *)resultvalue values:(NSArray *)values{
    
    if(!values.count) return nil;
    __block NSString *value = nil;
    [values enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj respondsToSelector:@selector(objectForKey:)]){
            if([obj[key] integerValue] == [valueKey integerValue]){
                value = [NSString stringWithFormat:@"%@", obj[resultvalue]];
            }
        }
    }];
    return value;
    
}




// 字符串加
+ (NSString *)addV1:(NSString *)v1 v2:(NSString *)v2 {
    CGFloat result = [v1 floatValue] + [v2 floatValue];
    return [NSString stringWithFormat:@"%.2f", result];
}

// 字符串减
+ (NSString *)subV1:(NSString *)v1 v2:(NSString *)v2 {
    CGFloat result = [v1 floatValue] - [v2 floatValue];
    return [NSString stringWithFormat:@"%.2f", result];
}

// 字符串乘
+ (NSString *)mulV1:(NSString *)v1 v2:(NSString *)v2 {
    CGFloat result = [v1 floatValue] * [v2 floatValue];
    return [NSString stringWithFormat:@"%.2f", result];
}

// 字符串除
+ (NSString *)divV1:(NSString *)v1 v2:(NSString *)v2 {
    CGFloat result = [v1 floatValue] / [v2 floatValue];
    return [NSString stringWithFormat:@"%.2f", result];
}

// 简单只包含 + - 的计算
+ (NSString *)calcSimpleFormula:(NSString *)formula {
    
    NSString *result = @"0";
    char symbol = '+';
    
    int len = formula.length;
    int numStartPoint = 0;
    for (int i = 0; i < len; i++) {
        char c = [formula characterAtIndex:i];
        if (c == '+' || c == '-') {
            NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, i - numStartPoint)];
            switch (symbol) {
                case '+':
                    result = [self addV1:result v2:num];
                    break;
                case '-':
                    result = [self subV1:result v2:num];
                    break;
                default:
                    break;
            }
            symbol = c;
            numStartPoint = i + 1;
        }
    }
    if (numStartPoint < len) {
        NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, len - numStartPoint)];
        switch (symbol) {
            case '+':
                result = [self addV1:result v2:num];
                break;
            case '-':
                result = [self subV1:result v2:num];
                break;
            default:
                break;
        }
    }
    return result;
}

// 获取字符串中的后置数字
+ (NSString *)lastNumberWithString:(NSString *)str {
    int numStartPoint = 0;
    for (int i = str.length - 1; i >= 0; i--) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numStartPoint = i + 1;
            break;
        }
    }
    return [str substringFromIndex:numStartPoint];
}

// 获取字符串中的前置数字
+ (NSString *)firstNumberWithString:(NSString *)str {
    int numEndPoint = str.length;
    for (int i = 0; i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numEndPoint = i;
            break;
        }
    }
    return [str substringToIndex:numEndPoint];
}

// 包含 * / 的计算
+ (NSString *)calcNormalFormula:(NSString *)formula {
    NSRange mulRange = [formula rangeOfString:@"*" options:NSLiteralSearch];
    NSRange divRange = [formula rangeOfString:@"/" options:NSLiteralSearch];
    // 只包含加减的运算
    if (mulRange.length == 0 && divRange.length == 0) {
        return [self calcSimpleFormula:formula];
    }
    // 进行乘除运算
    int index = mulRange.length > 0 ? mulRange.location : divRange.location;
    // 计算左边表达式
    NSString *left = [formula substringWithRange:NSMakeRange(0, index)];
    NSString *num1 = [self lastNumberWithString:left];
    left = [left substringWithRange:NSMakeRange(0, left.length - num1.length)];
    // 计算右边表达式
    NSString *right = [formula substringFromIndex:index + 1];
    NSString *num2 = [self firstNumberWithString:right];
    right = [right substringFromIndex:num2.length];
    // 计算一次乘除结果
    NSString *tempResult = @"0";
    if (index == mulRange.location) {
        tempResult = [self mulV1:num1 v2:num2];
    } else {
        tempResult = [self divV1:num1 v2:num2];
    }
    // 代入计算得到新的公式
    NSString *newFormula = [NSString stringWithFormat:@"%@%@%@", left, tempResult, right];
    return [self calcNormalFormula:newFormula];
}

// 复杂计算公式计算,接口主方法
+ (NSString *)calcComplexFormulaString:(NSString *)formula {
    // 左括号
    NSRange lRange = [formula rangeOfString:@"(" options:NSBackwardsSearch];
    // 没有括号进行二步运算(含有乘除加减)
    if (lRange.length == 0) {
        return [self calcNormalFormula:formula];
    }
    // 右括号
    NSRange rRange = [formula rangeOfString:@")" options:NSLiteralSearch range:NSMakeRange(lRange.location, formula.length-lRange.location)];
    // 获取括号左右边的表达式
    NSString *left = [formula substringWithRange:NSMakeRange(0, lRange.location)];
    NSString *right = [formula substringFromIndex:rRange.location + 1];
    // 括号内的表达式
    NSString *middle = [formula substringWithRange:NSMakeRange(lRange.location+1, rRange.location-lRange.location-1)];
    // 代入计算新的公式
    NSString *newFormula = [NSString stringWithFormat:@"%@%@%@", left, [self calcNormalFormula:middle], right];
    return [self calcComplexFormulaString:newFormula];
}

+ (NSString *)formatCurrency:(NSString *)string
{
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    [currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [currencyStyle setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *balance = [currencyStyle numberFromString:string];
    [currencyStyle setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString* formatted = [currencyStyle stringFromNumber:balance];
    
    return formatted;
}

+ (NSMutableAttributedString *)addUnderLineString:(NSString *)string {
    
    NSMutableAttributedString  *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedStr addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:NSMakeRange(0, string.length)];
    
    return attributedStr;
}

@end


//
//  BLCheckUtility.m
//  MeiFang
//
//  Created by ChenBaolin on 2016/2/14.
//  Copyright © 2017年 Vanke.com All rights reserved.
//

#import "VKCheckUtility.h"

@implementation VKCheckUtility

#pragma mark -
#pragma mark 检查数据
+ (BOOL)checkObjectAvailable:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return NO;
    }
    
    if ([object isKindOfClass:[NSString class]])
    {
        if ([object isEqualToString:@""] || [object isEqualToString:@"null"]) {
            return NO;
        }
        
        return YES;
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
        NSArray *array = (NSArray *)object;
        if (array.count>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)object;
        if (dict.count>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSData class]])
    {
        NSData *data = (NSData *)object;
        if (data.length>0) {
            return YES;
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        if (object == nil || [object isEqual:[NSNull null]])
        {
            return NO;
        }
        return YES;
        
    }
    else if ([object isKindOfClass:[NSValue class]])
    {
        if (object == nil || [object isEqual:[NSNull null]]) {
            return NO;
        }
        return YES;
    }
    else if ([object isKindOfClass:[NSObject class]])
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)checkIdNo:(NSString *)identity
{
    BOOL flag;
    if (identity.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identity];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identity.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identity substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identity substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
    return NO;
}

+ (BOOL)checkMobileNo:(NSString *)phone forType:(NSInteger)type
{
    if (type == 1) {
        NSString * cm = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[2-478])\\d)\\d{7}$";
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
        if ([regextestcm evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 2)
    {
        NSString * cu = @"^1(3[0-2]|5[56]|76|8[56])\\d{8}$";
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
        if ([regextestcu evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 3)
    {
        NSString * ct = @"^1((33|53|7[37]|8[019])[0-9]|349)\\d{7}$";
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
        if ([regextestct evaluateWithObject:phone]) {
            return YES;
        }
    }
    else if (type == 4){
        NSString * mobile = @"^1(3[0-9]|5[0-35-9]|47|7[0-9]|8[0-9])\\d{8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
        if ([regextestmobile evaluateWithObject:phone]) {
            return YES;
        }
    }
    else {
        NSString * mobile = @"^1([0-9])\\d{9}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
        if ([regextestmobile evaluateWithObject:phone]) {
            return YES;
        }
    }
    
    return NO;    
}

+ (BOOL)checkMobileNo:(NSString *)phone
{
    if (phone.length == 11){
        if ([[phone substringToIndex:1] isEqualToString:@"1"]) {
            return YES;
        }
    }
    return NO;
}


//-------------------------货币格式-------------------------------//
+ (NSString *)getRMBCurrencyFormatter:(id )obj
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = nil;
    if ([obj isKindOfClass:[NSNumber class]])
    {
        number = obj;
    }
    else
    {
        number = [formatter numberFromString:[NSString stringWithFormat:@"%@",obj]];
    }
    NSString* formatted = [formatter stringFromNumber:number];
    
    return [NSString stringWithFormat:@"￥%@",formatted];
}

+ (NSString *)getCurrencyFormatter:(id )obj
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = nil;
    if ([obj isKindOfClass:[NSNumber class]])
    {
        number = obj;
    }
    else
    {
        number = [formatter numberFromString:[NSString stringWithFormat:@"%@",obj]];
    }
    NSString* formatted = [formatter stringFromNumber:number];
    
    return formatted;
}
//---------------------------时间处理--------------------------//

+ (NSString *)getWeekDayFromDateString:(NSString *)datetime formatter:(NSString *)format
{
    NSDate *date = [VKCheckUtility stringToDate:datetime formatter:format];
    
    return [VKCheckUtility getWeekDayFromDate:date];
}

+ (NSString *)getWeekDayFromDate:(NSDate *)date
{
    //待完善
    return nil;
}

+ (NSDate *)stringToDate:(NSString *)datetime formatter:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [dateFormatter  dateFromString:datetime];
    
    return date;
}


+ (NSString *)dateToString:(NSDate *)datetime formatter:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [dateFormatter stringFromDate:datetime];
    
    return dateString;
}


+ (NSString *)changeDate:(NSString *)dateStr fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat
{
    NSDate *date = [VKCheckUtility stringToDate:dateStr formatter:fromFormat];
    NSString *dateString = [VKCheckUtility dateToString:date formatter:toFormat];
    
    return dateString;
}

+ (NSString *)getStringFromDict:(NSDictionary *)dict withKey:(id)key
{
    NSString *string = @"";
    if ([VKCheckUtility checkObjectAvailable:[dict objectForKey:key]])
    {
        string = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    }
    return string;
}

//补充其它对象取值

+ (NSDictionary *)getDictionaryFromDict:(NSDictionary *)dict withKey:(id)key
{
    id object = [dict objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    
    return nil;
}

@end

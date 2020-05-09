//
//  VKDateFormatUtil.m
//  MeiFangManager
//
//  Created by Evan on 2016/11/30.
//  Copyright © 2016年 XXXX.com All rights reserved.
//

#import "VKDateFormatUtil.h"

@implementation VKDateFormatUtil

+ (NSString *)thisWeek {
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSInteger unitFlagsR = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:unitFlags fromDate:nowDate];

    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    
    long firstDiff;
    long lastDiff;

    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff =  0;
    }
    else {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 0;
    }

    NSDateComponents *firstDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];

    NSString *dateString = [VKDateFormatUtil fromDate:firstDayOfWeek toDate:lastDayOfWeek];
    return [NSString stringWithFormat:@"本周%@", dateString];
}
    
+ (NSString *)last1Week {
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSInteger unitFlagsR = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:unitFlags fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    
    long firstDiff;
    long lastDiff;
    
    if (weekDay == 1) {
        firstDiff = -7-6;
        lastDiff = -7+0;
    }
    else {
        firstDiff = -7+[calendar firstWeekday] - weekDay + 1;
        lastDiff = -7+8 - weekDay;
    }
    
    NSDateComponents *firstDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSString *dateString = [VKDateFormatUtil fromDate:firstDayOfWeek toDate:lastDayOfWeek];
    return [NSString stringWithFormat:@"上周%@", dateString];
}

+ (NSString *)last2Week {
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSInteger unitFlagsR = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:unitFlags fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    
    long firstDiff;
    long lastDiff;
    
    if (weekDay == 1) {
        firstDiff = -14-6;
        lastDiff = -14+0;
    }
    else {
        firstDiff = -14+[calendar firstWeekday] - weekDay + 1;
        lastDiff = -14+8-weekDay;
    }
    
    NSDateComponents *firstDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:unitFlagsR fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSString *dateString = [VKDateFormatUtil fromDate:firstDayOfWeek toDate:lastDayOfWeek];
    return [NSString stringWithFormat:@"上上周%@", dateString];
}


+ (NSString *)dateFormatFromLastWeeks:(NSUInteger)count {
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:unitFlags fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff;
    long lastDiff;
    
    if (count == 0) {
        if (weekDay == 1) {
            firstDiff = -6;
            lastDiff =  0;
        }
        else {
            firstDiff = [calendar firstWeekday] - weekDay + 1;
            lastDiff = 0;
        }
    } else {
        if (weekDay == 1) {
            firstDiff = -(count*7)-6;
            lastDiff = -(count)*7+0;
        }
        else {
            firstDiff = -(count*7)+[calendar firstWeekday] - weekDay + 1;
            lastDiff = -(count*7)+8 - weekDay;
        }
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:unitFlags  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:unitFlags   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];

    return [VKDateFormatUtil fromDate:firstDayOfWeek toDate:lastDayOfWeek];
}

+ (NSString *)fromDate:(NSDate *)foromDate toDate:(NSDate *)toDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *firstDay = [formatter stringFromDate:foromDate];
    NSString *lastDay = [formatter stringFromDate:toDate];
    NSString *dateStr = [NSString stringWithFormat:@"（%@-%@）",firstDay,lastDay];
    return dateStr;
}

+ (NSUInteger)thisDayIndexOfThisWeek {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    NSInteger day = theComponents.weekday;
    if (day == 0) {
        return 6;
    }
    else {
        return day-2;
    }

}

@end

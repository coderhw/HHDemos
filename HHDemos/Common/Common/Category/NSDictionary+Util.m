//
//  NSDictionary+Util.m
//  MeiFang
//
//  Created by Evan on 2016/12/25.
//  Copyright © 2016年 XXXX.com All rights reserved.
//

#import "NSDictionary+Util.h"

@implementation NSDictionary (Util)


+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSDictionary *)mockJson:(NSString *)name {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    if (jsonPath){
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        if (jsonData) {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:jsonString];
            if (jsonString) {
                return result;
            }
            else {
                NSLog(@"json parse error");
            }
        }else {
            NSLog(@"json data error");
        }
    }else {
        NSLog(@"jsonpath = nil");
    }
    return nil;
}

@end

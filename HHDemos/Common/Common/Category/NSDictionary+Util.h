//
//  NSDictionary+Util.h
//  MeiFang
//
//  Created by Evan on 2016/12/25.
//  Copyright © 2016年 Vanke.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Util)

//NSDictionart -> String
+ (NSString*)convertToJSONData:(id)infoDict;

//JsonString -> Dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSDictionary *)mockJson:(NSString *)path;

@end

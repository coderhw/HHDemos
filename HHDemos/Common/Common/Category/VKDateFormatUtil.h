//
//  MFDateFormatModel.h
//  MeiFangManager
//
//  Created by Evan on 2016/11/30.
//  Copyright © 2016年 XXXX.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKDateFormatUtil : NSObject

+ (NSString *)thisWeek;

+ (NSString *)last1Week;

+ (NSString *)last2Week;

+ (NSUInteger)thisDayIndexOfThisWeek;

@end

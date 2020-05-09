//
//  Logger.m
//  xiaonei
//
//  Created by citydeer on 09-4-14.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TTLogger.h"
#import "DDFileLogger.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation TTLogger

+ (NSString *)ExtractFileNameWithoutExtension:(const char *)filePath needCopy:(BOOL)copy;
{
    if (filePath == NULL)
        return nil;

    char *lastSlash = NULL;
    char *lastDot = NULL;

    char *p = (char *)filePath;

    while (*p != '\0') {
        if (*p == '/')
            lastSlash = p;
        else if (*p == '.')
            lastDot = p;

        p++;
    }

    char *subStr;
    NSUInteger subLen;

    if (lastSlash) {
        if (lastDot) {
            // lastSlash -> lastDot
            subStr = lastSlash + 1;
            subLen = lastDot - subStr;
        } else {
            // lastSlash -> endOfString
            subStr = lastSlash + 1;
            subLen = p - subStr;
        }
    } else {
        if (lastDot) {
            // startOfString -> lastDot
            subStr = (char *)filePath;
            subLen = lastDot - subStr;
        } else {
            // startOfString -> endOfString
            subStr = (char *)filePath;
            subLen = p - subStr;
        }
    }

    if (copy) {
        return [[NSString alloc] initWithBytes:subStr length:subLen encoding:NSUTF8StringEncoding];
    } else {
        // We can take advantage of the fact that __FILE__ is a string literal.
        // Specifically, we don't need to waste time copying the string.
        // We can just tell NSString to point to a range within the string literal.

        return [[NSString alloc] initWithBytesNoCopy:subStr length:subLen encoding:NSUTF8StringEncoding freeWhenDone:NO];
    }
}

+ (void)setUp
{
    //日志处理
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"/Caches/Logs"];
    
    DDLogFileManagerDefault *fileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logsDirectory];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
    
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    
    [DDLog addLogger:fileLogger];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}


@end

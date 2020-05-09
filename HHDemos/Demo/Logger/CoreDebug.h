//
//  CoreDebug.h
//  Pods
//
//  Created by bolei on 15/8/27.
//
//

#ifndef Pods_CoreDebug_h
#define Pods_CoreDebug_h

#ifdef __OBJC__
#import "DDLog.h"
#import "TTLogger.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_INFO; //定义log的等级
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

#endif

#endif

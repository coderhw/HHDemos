//
//

#import <Foundation/Foundation.h>

#define DDLEGACY YES
#import "DDLog.h"

#define LogAsync        YES
#define LogContext      65535

//level
/*
LOG_LEVEL_VERBOSE
LOG_LEVEL_INFO
LOG_LEVEL_WARN
LOG_LEVEL_ERROR
LOG_LEVEL_OFF
*/


// 使用 LogError LogWarn LogInfo LogVerbose 进行调试输出。LogCError等版本用于在C风格函数中使用
// RS_LOG_LEVEL ,控制打印LOG的等级，可选项为上面五个，关掉LOG，则为LOG_LEVEL_OFF

#if DEBUG
#define RS_LOG_LEVEL     LOG_LEVEL_INFO
#else
#define RS_LOG_LEVEL     LOG_LEVEL_ERROR
#endif

#define THIS_FILE_NAME [TTLogger ExtractFileNameWithoutExtension:__FILE__ needCopy:NO]


#define LogObjc(flg, frmt, ...) LOG_OBJC_MAYBE(LogAsync, RS_LOG_LEVEL, flg, LogContext, frmt, ##__VA_ARGS__)
#define LogC(flg, frmt, ...)    LOG_C_MAYBE(LogAsync, RS_LOG_LEVEL, flg, LogContext, frmt, ##__VA_ARGS__)

#define LogError(frmt, ...)     LogObjc(LOG_FLAG_ERROR,   (@"[ERROR]%@,%@ " frmt), THIS_FILE_NAME,THIS_METHOD,  ##__VA_ARGS__)
#define LogCError(frmt, ...)    LogC(LOG_FLAG_ERROR,   (@"[ERROR]%@,%s " frmt), THIS_FILE_NAME, __FUNCTION__,##__VA_ARGS__)

#define LogDebug(frmt, ...)   LogObjc(LOG_FLAG_ERROR, (@"[ERROR]%@,%@ " frmt), THIS_FILE_NAME,THIS_METHOD, ##__VA_ARGS__)
#define LogCDebug(frmt, ...)    LogC(LOG_FLAG_ERROR,   (@"[ERROR]%@,%s " frmt), THIS_FILE_NAME, __FUNCTION__,##__VA_ARGS__)

#define LogWarn(frmt, ...)      LogObjc(LOG_FLAG_WARN,    (@"[WARN]%@,%@ " frmt), THIS_FILE_NAME,THIS_METHOD, ##__VA_ARGS__)
#define LogCWarn(frmt, ...)     LogC(LOG_FLAG_WARN,    (@"[WARN]%@,%s " frmt), THIS_FILE_NAME,__FUNCTION__, ##__VA_ARGS__)

#define LogInfo(frmt, ...)      LogObjc(LOG_FLAG_INFO,    (@"[INFO]%@,%@ " frmt), THIS_FILE_NAME,THIS_METHOD, ##__VA_ARGS__)
#define LogCInfo(frmt, ...)     LogC(LOG_FLAG_INFO,    (@"[INFO]%@,%s" frmt), THIS_FILE_NAME, __FUNCTION__,##__VA_ARGS__)

#define LogVerbose(frmt, ...)   LogObjc(LOG_FLAG_VERBOSE, (@"[VERBOSE]%@,%@ " frmt), THIS_FILE_NAME,THIS_METHOD, ##__VA_ARGS__)
#define LogCVerbose(frmt, ...)  LogC(LOG_FLAG_VERBOSE, (@"[BERBOSE]%@,%s " frmt), THIS_FILE_NAME,__FUNCTION__, ##__VA_ARGS__)


@interface TTLogger : NSObject

+(NSString *)ExtractFileNameWithoutExtension:(const char *)filePath needCopy:(BOOL) copy;

//初始化方法，请在appDelegate中application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions调用
+(void)setUp;

@end


//
//  ESDebug.h
//

/**
 * Modified from Three20 Debugging tools.
 *
 * Provided in this header are a set of debugging tools. This is meant quite literally, in that
 * all of the macros below will only function when the DEBUG preprocessor macro is specified.
 *
 * TTDASSERT(<statement>);
 * If <statement> is false, the statement will be wrESen to the log and if you are running in
 * the simulator with a debugger attached, the app will break on the assertion line.
 *
 * TTDPRINT(@"formatted log text %d", param1);
 * Print the given formatted text to the log.
 *
 * TTDPRINTMETHODNAME();
 * Print the current method to the log.
 *
 * TTDCONDITIONLOG(<statement>, @"formatted log text %d", param1);
 * Only if <statement> is true then the formatted text will be wrESen to the log.
 *
 * TTDINFO/TTDWARNING/TTDERROR(@"formatted log text %d", param1);
 * Will only write the formatted text to the log if TTMAXLOGLEVEL is greater than the respective
 * TTD* method's log level. See below for log levels.
 *
 * The default maximum log level is TTLOGLEVEL_WARNING.
 */
#define ESDEBUG
#define ESLOGLEVEL_INFO     10
#define ESLOGLEVEL_WARNING  3
#define ESLOGLEVEL_ERROR    1

#ifndef ESMAXLOGLEVEL

#define ESMAXLOGLEVEL ESLOGLEVEL_INFO

#endif

// The general purpose logger. This ignores logging levels.
//#ifdef ESDEBUG
//  #define ESDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//  #define ESDPRINT(xx, ...)  ((void)0)
//#endif

#ifndef QA
//# define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
# define NSLog(fmt, ...) NSLog(fmt ,##__VA_ARGS__);
#else
# define NSLog(...) ((void)0);
#endif

// Prints the current method's name.
#define ESDPRINTMETHODNAME() NSLog(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ESLOGLEVEL_ERROR <= ESMAXLOGLEVEL
#define ESDERROR(xx, ...)  NSLog(xx, ##__VA_ARGS__)
#else
  #define ESDERROR(xx, ...)  ((void)0)
#endif

#if ESLOGLEVEL_WARNING <= ESMAXLOGLEVEL
#define ESDWARNING(xx, ...)  NSLog(xx, ##__VA_ARGS__)
#else
  #define ESDWARNING(xx, ...)  ((void)0)
#endif

#if ESLOGLEVEL_INFO <= ESMAXLOGLEVEL
#define ESDINFO(xx, ...)  NSLog(xx, ##__VA_ARGS__)
#else
  #define ESDINFO(xx, ...)  ((void)0)
#endif

#ifdef ESDEBUG
#define ESDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
                                                  NSLog(xx, ##__VA_ARGS__); \
                                                } \
                                              } ((void)0)
#else
  #define ESDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif


#define ESAssert(condition, ...)                                       \
do {                                                                      \
    if (!(condition)) {                                                     \
        [[NSAssertionHandler currentHandler]                                  \
            handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                file:[NSString stringWithUTF8String:__FILE__]  \
                            lineNumber:__LINE__                                  \
                            description:__VA_ARGS__];                             \
    }                                                                       \
} while(0)

//
//  ESCommonMacros.h
//  
//
//  Created by jason on 6/15/12.
//  Copyright (c) 2013 fashion. All rights reserved.
//


////////////////////////////////////////////////////////////////////////////////
#pragma mark - shortcuts

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]



//#define DATA_ENV [DataEnvironment sharedDataEnvironment]

#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]]

////////////////////////////////////////////////////////////////////////////////
#pragma mark - common functions 

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


////////////////////////////////////////////////////////////////////////////////
#pragma mark - iphone 5 detection functions

#define SCREEN_HEIGHT_OF_IPHONE5 568

#define is4InchScreen() ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)

#define Iphone4ch  (is4InchScreen() ? 10 :  100)

////////////////////////////////////////////////////////////////////////////////
#pragma mark - degrees/radian functions 

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#define radianToDegrees(radian) (radian*180.0)/(M_PI)

////////////////////////////////////////////////////////////////////////////////
#pragma mark - color functions 

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 定义RGB宏函数
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]


#define PADICTIONARY_VALUE_NAME(a,b) [NSDictionary dictionaryWithObjectsAndKeys:a,@"value",b,@"name",nil]


#define AppVersion            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// 判断是否越狱
#define IS_JailBreak            system("ls") == 0 ? YES : NO

// 机器语言
#define HXApplicationLanguage   [[NSUserDefaults standardUserDefaults] \
objectForKey:@"AppleLanguages"]                                    \
objectAtIndex : 0];

// ios版本
#define IOSVersion              [[[UIDevice currentDevice] systemVersion] floatValue];

#define NEW(CLASS_NAME)  [[CLASS_NAME alloc]init]

#define HFAlert(fmt, ...)                                                                                                                                                                               \
{                                                                                                                                                                                                   \
UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:fmt,##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] ; \
[alert1 show];                                                                                                                                                                                  \
}

#define HFAlert_T_M_BT(t, m, bt)                                                                                                                                    \
{                                                                                                                                                               \
UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:t message:m delegate:nil cancelButtonTitle:bt otherButtonTitles:nil] ; [alert1 show]; \
}










//
//  CONSTS.h
//  jason

//
//  Copyright 2013 Studio. All rights reserved.
//


#pragma mark - Global defines

// 注意：
// 如果想编译连接生产环境的应用，请选择Huaxia Prod做为target
// 如果想编译连接测试环境的应用，请选择Huaxia QA做为target


#ifdef PRODUCTION
//******************生产环境*******************//

#define HQT_HOST @"https://fundtrade.chinaamc.com:444/hqt-server/"

#else

//****************测试环境**************//
#define HQT_HOST @"https://10.67.4.81/hqt-server/"

#endif


#define ALERTQUITTAG 200000

#define HX_SANQI_IDENTIFYINGCODE @"hx_identifyingCode"

#define HX_SANQI_PHONENUMBER @"4008186666"

#define kDefaultNetworkWarning  @"联网失败！"

#define USER_CANADDPLAN @"USER_CANADDPLAN"


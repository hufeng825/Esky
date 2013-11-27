//
//  ESConfig.h
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseModel.h"

@interface ESConfig : ESBaseModel{
    //应用App Store的ID（AppleID）
    NSString *_appStoreId;
    // 应用App Store的Bundle ID
    NSString *_appBundleID;
    // 手机名称
    NSString *_sysName;
    // app版本
    NSString *_appversion;
    // 系统版本
    NSString *_sysversion;
    // 设备型号
    NSString *_deviceModel;
    // 客户端信息（client_info）
    NSDictionary *_clientInfo;

    // 客户端当前的语言环境
    NSString *_currentLanguage;
    // 客户端发布日期
    NSString *_pubdate;
    // UA信息
    NSString* _userAgent;
}

+ (ESConfig* )globalConfig;
+ (void)setGlobalConfig:(ESConfig *)config;


// udid 取设备 MAC(兼容)
- (NSString *)udid;

//应用App Store的ID（AppleID）
@property (nonatomic, copy) NSString *appStoreId;
// 应用App Store的Bundle ID
@property (nonatomic, copy) NSString *appBundleID;
// 客户端版本
@property (nonatomic, copy) NSString *appversion;
// 客户端名称
@property (nonatomic, copy) NSString *sysName;
// 系统版本
@property (nonatomic, copy) NSString *sysversion;
// 设备型号
@property (nonatomic, copy) NSString *deviceModel;
// 客户端信息（client_info）
@property (nonatomic, copy) NSDictionary *clientInfo;

@property (nonatomic, copy) NSString *currentLanguage;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString* userAgent;

- (void)updateUserAgent;

@end

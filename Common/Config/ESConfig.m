//
//  ESConfig.m
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESConfig.h"
#import "ESMainUser.h"



static ESConfig *_globalConfig = nil;


@implementation ESConfig


- (NSString *)udid{
    return nil;
//    return [UIDevice macAddress];
}

+ (ESConfig* )globalConfig {

    @synchronized (self){
        if(!_globalConfig) {
            _globalConfig = [[ESConfig alloc] init];
        }
    }
    return _globalConfig;
}

+ (void)setGlobalConfig:(ESConfig *)config {
    if (_globalConfig != config) {
        _globalConfig = config;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        UIDevice *device = [UIDevice currentDevice];
        UIScreen *screen = [UIScreen mainScreen];
        
        //应用App Store的ID（AppleID）
        self.appStoreId =  @"";
        
        // 应用App Store的Bundle ID
        self.appBundleID = [infoDictionary objectForKey:(NSString *)kCFBundleIdentifierKey];
        
        // 手机名称
        self.sysName = [device name];
        
        // 系统版本
        self.sysversion = [device systemName];
        
        //客户端版本
        self.appversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        // 设备型号
        self.deviceModel = [UIDevice  machineModel];
        
        
        // 客户端信息（client_info）
        CGSize screenSize = screen.bounds.size;
        NSString *otherStr = @"";
        NSString *carrierCode = [UIDevice carrierCode];
        if (carrierCode) {
            otherStr = [otherStr stringByAppendingString:carrierCode];
        }
        otherStr = [otherStr stringByAppendingString:@","];
        
        self.clientInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.deviceModel, @"model",
                           [UIDevice macAddress], @"mac",
                           [NSString stringWithFormat:@"%@%@", device.systemName, device.systemVersion], @"os" ,
                           [UIDevice macAddress], @"systemName",
                           [NSString stringWithFormat:@"%.0fX%.0f", screenSize.width, screenSize.height], @"screen",
                           self.appversion, @"appversion",
                           otherStr, @"other",
                           nil];
        NSString* sidStr = @"";
        NSString* sid = [ESMainUser getInstance].userId;
        if(!sid){
            sidStr = @"";
        }
        else{
            sidStr = sid;
        }
      
        
        self.userAgent = [NSString stringWithFormat:@"{\"mac\":\"%@\",\"deviceName\":\"%@\",\"deviceVersion\":\"%@\",\"screen\":\"%@\",\"appVersion\":\"%@\",\"sid\":\"%@\"}",[UIDevice macAddress],self.deviceModel,device.systemVersion,[NSString stringWithFormat:@"%.0f*%.0f", screenSize.width, screenSize.height],self.appversion,sidStr];
        
        self.currentLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
        self.pubdate = @"20121101";
    }
    return self;
}

- (void)updateUserAgent
{
    NSString* sid = [ESMainUser getInstance].userId;
    UIDevice *device = [UIDevice currentDevice];
    UIScreen *screen = [UIScreen mainScreen];
    CGSize screenSize = screen.bounds.size;
//    NSString* cityId = @"";
//    if([ESMainUser getInstance].currentCityId){
//        cityId = [NSString stringWithFormat:@"%d",[[ESMainUser getInstance].currentCityId intValue]];
//    }
//    
    self.userAgent = [NSString stringWithFormat:@"{\"mac\":\"%@\",\"deviceName\":\"%@\",\"deviceVersion\":\"%@\",\"screen\":\"%@\",\"clientVersion\":\"%@\",\"sid\":\"%@\"}",[UIDevice macAddress],self.deviceModel,device.systemVersion,[NSString stringWithFormat:@"%.0f*%.0f", screenSize.width, screenSize.height],self.appversion,sid];
}

@end

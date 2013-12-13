//
//  ESRequestParameters.h
//  EskyApp
//
//  Created by jason on 13-12-5.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFHttpRequestParameters.h"

#import "NSObject+JTObjectMapping.h"


static NSString * const kAliYun_API_HOST = @"http://esky.esquire.com.cn:8080/trends/";
static NSString * const kYangYI_API_HOST = @"http://192.168.24.95:8081/trends/";

//static NSString * const API_HOST = kAliYun_API_HOST;
#define API_HOST kAliYun_API_HOST

@interface ESRequestParameters : HFHttpRequestParameters

//注册接口

+ (ESRequestParameters *) requestRegisterParametersWithUserName: (NSString *)userName
                                              nickName: (NSString *)nickName
                                                avatar: (NSString *)avatarpath
                                              password: (NSString *)password;


//登录接口
+ (ESRequestParameters *) requestLoginParametersWithUsername:(NSString *)username
                                        passWord:(NSString *)passWord;
//重置密码接口
+ (ESRequestParameters *) requestResetPasswordParametersWithUsername:(NSString *)username;


@end

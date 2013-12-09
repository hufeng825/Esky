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



@interface ESRequestParameters : HFHttpRequestParameters

//注册接口

+ (ESRequestParameters *) requestRegisterParametersWithEmail:(NSString *)email
                                              userName: (NSString *)userName
                                              nickName: (NSString *)nickName
                                                avatar: (NSString *)avatarpath
                                              password: (NSString *)password;


+ (ESRequestParameters *) requestLoginParametersWithUsername:(NSString *)username
                                        passWord:(NSString *)passWord;

@end

//
//  ESRequestParameters.m
//  EskyApp
//
//  Created by jason on 13-12-5.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRequestParameters.h"

@implementation ESRequestParameters

+ (ESRequestParameters *)requestRegisterParametersWithUserName:(NSString *)userName
                                                         email:(NSString *)email
                                                      nickName:(NSString *)nickName
                                                        avatar:(NSString *)avatarpath
                                                      password:(NSString *)password {
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    [parameter stringWithHost:API_HOST api:@"account/register.json"];
    [parameter setString:email forKey:@"email"];
    [parameter setString:userName forKey:@"userName"];
    [parameter setString:nickName forKey:@"nickname"];
    [parameter setString:[password stringFromMD5] forKey:@"password"];
    [parameter setString:avatarpath forKey:@"avatar"];
    return parameter;
};

+ (ESRequestParameters *)requestLoginParametersWithUsername:(NSString *)username
                                                      email:(NSString *)email
                                                   passWord:(NSString *)passWord {
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    [parameter stringWithHost:API_HOST api:@"account/login.json"];
    [parameter setString:username forKey:@"username"];
    [parameter setString:email forKey:@"email"];
    [parameter setString:passWord forKey:@"password"];
    return parameter;
};

+ (ESRequestParameters *)requestResetPasswordParametersWithUsername:(NSString *)username {
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    [parameter stringWithHost:API_HOST api:@"account/passwordReset.json"];
    [parameter setString:username forKey:@"username"];
    return parameter;
};


@end

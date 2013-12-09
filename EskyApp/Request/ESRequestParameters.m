//
//  ESRequestParameters.m
//  EskyApp
//
//  Created by jason on 13-12-5.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRequestParameters.h"

@implementation ESRequestParameters

+ (ESRequestParameters *) requestRegisterParametersWithEmail:(NSString *)email
                                              userName:(NSString *)userName
                                              nickName:(NSString *)nickName
                                                avatar:(NSString *)avatarpath
                                              password:(NSString *)password
{
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    
    [parameter stringWithHost:kYangYI_API_HOST api:@"account/register.json"];
    [parameter setString:email forKey:@"email"];
    [parameter setString:userName forKey:@"username"];
    [parameter setString:nickName forKey:@"nickname"];
    [parameter setString:[password  stringFromMD5] forKey:@"password"];
    
//    [parameter setObject:imageData forKey:@"avatar"];
    return parameter;
};



+ (ESRequestParameters *) requestLoginParametersWithUsername:(NSString *)username
                                                    passWord:(NSString *)passWord
{
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    [parameter stringWithHost:kAliYun_API_HOST api:@"account/login.json"];
    [parameter setString:username forKey:@"username"];
    [parameter setString:passWord forKey:@"password"];
    return parameter;
};
@end

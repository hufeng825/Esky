//
//  ESRequestParameters.m
//  EskyApp
//
//  Created by jason on 13-12-5.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRequestParameters.h"

@implementation ESRequestParameters

-(ESRequestParameters *) requestRegisterParametersWith:(NSString *)email
                                              userName:(NSString *)userName
                                              nickName:(NSString *)nickName
                                                avatar:(NSString *)avatarpath
                                              password:(NSString *)password
{
    ESRequestParameters *parameter = [[ESRequestParameters alloc] init];
    [parameter setString:email forKey:@"email"];
    [parameter setString:userName forKey:@"userName"];
    [parameter setString:nickName forKey:@"nickName"];
    [parameter setString:[password stringFromMD5] forKey:@"password"];
    [parameter setObject:[UIImage imageNamed:avatarpath] forKey:@"avatar"];
    return parameter;
};

@end

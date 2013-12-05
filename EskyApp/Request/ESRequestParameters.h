//
//  ESRequestParameters.h
//  EskyApp
//
//  Created by jason on 13-12-5.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFHttpRequestParameters.h"



@interface ESRequestParameters : HFHttpRequestParameters

//注册接口

-(ESRequestParameters *) requestRegisterParametersWith:(NSString *)email
                                              userName:(NSString *)userName
                                              nickName:(NSString *)nickName
                                                avatar:(NSString *)avatarpath
                                              password:(NSString *)password;


@end

//
//  ESUserInfo.m
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESUserInfo.h"

@implementation ESUserInfo


- (id)initWithDictionary:(NSDictionary *)info{
    self = [super init];
    
    if (self) {
        @autoreleasepool{
        self.gender = [info stringForKey:@"gender"];
        self.bindedMobile = [info stringForKey:@"bindedmobile"];
        self.age = [info stringForKey:@"age"];
        self.email = [info stringForKey:@"email"];
        self.userId = [info stringForKey:@"userId"];
        self.tinyurl = [info stringForKey:@"tinyurl"];
        self.headurl = [info stringForKey:@"headurl"];
        self.mainurl = [info stringForKey:@"mainurl"];
        self.online = [[info objectForKey:@"online"] boolValue];
        self.isRegister = [[info objectForKey:@"isRegister"]boolValue];
        self.phoneNum = [info stringForKey:@"phoneNum"];
        self.userName = [info stringForKey:@"userName"];
        }
    }
    
    return self;
}


@end

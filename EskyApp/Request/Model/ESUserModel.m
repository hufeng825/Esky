//
//  ESUserModel.m
//  EskyApp
//
//  Created by jason on 13-12-9.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESUserModel.h"

@implementation ESUserModel


- (id)initWithDictionary:(NSDictionary *)info {
    self = [super init];

    if (self) {
        @autoreleasepool {
            self.email = [info stringForKey:@"email"];
            self.userId = [info stringForKey:@"userId"];
            self.headUrl = [info stringForKey:@"avatar"];
            self.userName = [info stringForKey:@"userName"];
            self.nickName = [info stringForKey:@"nickName"];
        }
    }

    return self;
}


@end

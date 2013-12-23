//
//  HXHttpClient.m
//  HXFrame
//
//  Created by jason on 13-4-9.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFHttpResponArguments.h"

@implementation HFHttpResponArguments

@synthesize sucessRespon, failRespon, progressBlock, cachePolicy, userInfo;

- (id)init {
    self = [super init];
    if (self) {
        cachePolicy = [[HFHttpConfigure alloc] init];
        failRespon = nil;
        sucessRespon = nil;
        progressBlock = nil;
        userInfo = nil;
    }
    return self;
}

- (void)dealloc {
#if !__has_feature(objc_arc)
    [userInfo release];
    [cachePolicy release];
    [failRespon release];
    [sucessRespon release];
    [progressBlock release];
    [super dealloc];
#endif

}

@end

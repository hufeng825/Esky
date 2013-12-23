//
//  HFHttpCachePolicy.m
//  HFFrame
//
//  Created by jason on 13-4-9.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFHttpConfigure.h"

#define Default_Time_Interval 60.f
#define Default_Memory_Capacity 1*1024*1024

@implementation HFHttpConfigure

@synthesize timeInterval, cachePolicy, memoryCapacity;


- (id)init {
    self = [super init];
    if (self) {
        timeInterval = Default_Time_Interval;
        cachePolicy = NSURLRequestUseProtocolCachePolicy;
        memoryCapacity = Default_Memory_Capacity;
    }
    return self;
}
@end

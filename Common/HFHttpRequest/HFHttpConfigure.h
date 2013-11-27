//
//  HFHttpCachePolicy.h
//  HFFrame
//
//  Created by jason on 13-4-9.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFHttpConfigure : NSObject

@property (nonatomic,assign) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic,assign) NSTimeInterval timeInterval;
@property (nonatomic,assign) NSUInteger memoryCapacity;

@end

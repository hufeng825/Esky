//
//  NSDate+HFExtension.h
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HFExtension)

+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format;

- (NSString*)labelString;

@end

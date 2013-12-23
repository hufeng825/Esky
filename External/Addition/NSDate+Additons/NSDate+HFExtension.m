//
//  NSDate+HFExtension.m
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "NSDate+HFExtension.h"

@implementation NSDate (HFExtension)

+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format {
	if (format == nil)
		format = @"yyyy-MM-dd HH:mm:ss";
    
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:format];
	NSDate* result = [df dateFromString:string];
    
	return result;
}

- (NSString*)labelString {
	const int MINUTE	= 60;
	const int HOUR		= 60 * 60;
	const int DAY		= 24 * 60 * 60;
	
	NSString* result = @"未知时间";
	if (self != nil) {
		NSTimeInterval timeInterval = [self timeIntervalSince1970];
		NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
		
		int timeLeft = now - timeInterval;
		
		if (timeLeft > DAY) {
			result = [NSString stringWithFormat:@"%d天前", timeLeft / DAY];
		} else if (timeLeft > HOUR) {
			result = [NSString stringWithFormat:@"%d小时前", timeLeft / HOUR];
		} else {
			result = [NSString stringWithFormat:@"%d分钟前", timeLeft / MINUTE];
		}
	}
	return result;
}


@end

//
//  HFHttpRequestObject.m
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "HFHttpRequestObject.h"
#import "NSString+Additions.h"
#import "NSData+HFExtension.h"
#import "NSDate+HFExtension.h"

@implementation HFHttpRequestObject

- (NSArray *)allKeys
{
	return [self allKeys];
}

- (NSArray *)allValues
{
    return [self allValues];
}



- (NSString*)stringForKey:(NSString*)key
{
    return [self objectForKey:key];
}

- (NSInteger)intForKey:(NSString*)key
{
	return [[self stringForKey:key] intValue];
}

- (double)doubleForKey:(NSString*)key
{
	return [[self stringForKey:key] longLongValue];
}


- (BOOL)boolForKey:(NSString*)key
{
	return [[self stringForKey:key] boolValue];
}


- (NSDate*)dateForKey:(NSString*)key
{
    return [self dateForKey:key withFormat:@"yyyy-MM-dd HH:mm:ss"];
}


- (NSDate*)dateForKey:(NSString*)key withFormat:(NSString*)format
{
	return [NSDate dateWithString:[self stringForKey:key] format:format];
}

- (NSData*)dataForKey:(NSString*)key
{
	return [NSData dataFromBase64String:[self stringForKey:key]];
}



- (void)setString:(NSString*)value forKey:(NSString*)key
{
    assert(key != nil);
    if (value == nil)
        [self removeObjectForKey:key];
    else
        [self setObject:value forKey:key];
    
}


- (void)setInt:(NSInteger)value forKey:(NSString*)key
{
	[self setString:[NSString stringWithFormat:@"%d", value] forKey:key];
}


- (void)setDouble:(double)value forKey:(NSString*)key
{
	[self setString:[NSString stringWithFormat:@"%f", value] forKey:key];
}

- (void)setBool:(BOOL)value forKey:(NSString*)key
{
	[self setString:(value == NO) ? @"0" : @"1" forKey:key];
}


- (void)setDate:(NSDate*)value forKey:(NSString*)key
{
	[self setDate:value forKey:key withFormat:@"yyyy-MM-dd HH:mm:ss"];
}


- (void)setDate:(NSDate*)value forKey:(NSString*)key withFormat:(NSString*)format
{
	[self setString:[NSString stringWithDate:value format:format] forKey:key];
}


- (void)setData:(NSData*)value forKey:(NSString*)key
{
	[self setString:[NSString base64StringFromData:value] forKey:key];
}


@end

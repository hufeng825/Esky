//
//  HFHttpRequestObject.h
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFHttpRequestParameters : NSMutableDictionary

- (NSArray *)allKeys;

- (NSArray *)allValues;

- (NSString *)stringForKey:(NSString *)key;

- (NSInteger)intForKey:(NSString *)key;

- (double)doubleForKey:(NSString *)key;

- (BOOL)boolForKey:(NSString *)key;

- (NSDate *)dateForKey:(NSString *)key;

- (NSDate *)dateForKey:(NSString *)key withFormat:(NSString *)format;

- (NSData *)dataForKey:(NSString *)key;

- (void)setString:(NSString *)value forKey:(NSString *)key;

- (void)setInt:(NSInteger)value forKey:(NSString *)key;

- (void)setDouble:(double)value forKey:(NSString *)key;

- (void)setBool:(BOOL)value forKey:(NSString *)key;

- (void)setDate:(NSDate *)value forKey:(NSString *)key;

- (void)setDate:(NSDate *)value forKey:(NSString *)key withFormat:(NSString *)format;

- (void)setData:(NSData *)value forKey:(NSString *)key;

@end

//
//  HFHttpRequestObject.h
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"

@protocol  HFMultipartFormData <AFMultipartFormData>

@optional

- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * __autoreleasing *)error;


- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * __autoreleasing *)error;


- (void)appendPartWithInputStream:(NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;

- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;

- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;


- (void)appendPartWithHeaders:(NSDictionary *)headers
                         body:(NSData *)body;

- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;
@end



@interface HFHttpRequestParameters : NSObject
{
    
@protected
	NSMutableDictionary*	_args;

}

@property (nonatomic,copy,readonly) NSDictionary *arg;


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


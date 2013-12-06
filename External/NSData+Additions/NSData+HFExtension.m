//
//  NSData+HF.m
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "NSData+HFExtension.h"

#define xx 65
static unsigned char BASE64_BYTE_TABLE[256] = {
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
	xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
	xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
	xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
};

//
// Fundamental sizes of the binary and base64 encode/decode units in bytes
//
#define		BINARY_UNIT_SIZE	3
#define		BASE64_UNIT_SIZE	4

@implementation NSData (HFExtension)

+ (NSData*) dataFromBase64String: (NSString*)str {
	if (str == nil)
		return nil;
	
	const char* chars = [str UTF8String];
	NSUInteger charLen = [str length];
	
	size_t bufferSize = (charLen / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE;
	unsigned char *buffer = (unsigned char*)malloc(bufferSize);
	
	size_t i = 0;
	size_t dataLen = 0;
	while (i < charLen)
	{
		//
		// Accumulate 4 valid characters (ignore everything else)
		//
		unsigned char accumulated[BASE64_UNIT_SIZE];
		size_t accumulateIndex = 0;
		while (i < charLen)
		{
			unsigned char data = BASE64_BYTE_TABLE[chars[i++]];
			if (data != xx)
			{
				accumulated[accumulateIndex] = data;
				accumulateIndex++;
				
				if (accumulateIndex == BASE64_UNIT_SIZE)
				{
					break;
				}
			}
		}
		
		//
		// Store the 6 bits from each of the 4 characters as 3 bytes
		//
		buffer[dataLen] = (accumulated[0] << 2) | (accumulated[1] >> 4);
		buffer[dataLen + 1] = (accumulated[1] << 4) | (accumulated[2] >> 2);
		buffer[dataLen + 2] = (accumulated[2] << 6) | accumulated[3];
		dataLen += accumulateIndex - 1;
	}
	
	NSData* data = [NSData dataWithBytes:buffer length:dataLen];
    free(buffer);
    return data;
}
@end

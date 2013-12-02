//
//  NSData+HF.h
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HFExtension)
+ (NSData*) dataFromBase64String: (NSString*)str;
@end

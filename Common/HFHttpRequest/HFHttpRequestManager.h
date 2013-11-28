//
//  HFHttpRequest.h
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLResponseSerialization.h"
#import "AFHTTPRequestOperationManager.h"
#import "HFHttpRequestResult.h"
#import "HFHttpResponArguments.h"




typedef enum
{
    POSTHttpMethod,//content type = @"application/x-www-form-urlencoded"
    GETHttpMethod
    
}HFHttpMethod ;



@interface HFHttpRequestManager : AFHTTPRequestOperationManager


+(HFHttpRequestManager *)sharedClient;

+(HFHttpRequestManager *)client;


-(void)Url:(NSString*)url
    parameters:(NSDictionary *)parameters
    method:(HFHttpMethod)method
    ResponArgument:(HFHttpResponArguments *)responArguments;

@end

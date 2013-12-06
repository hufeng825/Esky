//
//  LogRequest.m
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRequest.h"


@implementation ESRequest


#pragma mark  -  网络请求

+ (HFHttpResponArguments *) httpResponArguments
{
    return [[HFHttpResponArguments alloc]init];
};


+ (void)postUrl         :(NSString *)url
        postArguments   :(ESRequestParameters *)parameters
        ResponArgument  :(HFHttpResponArguments *)responArguments
{
    [ [ self  sharedClient] Url:url parameters:(NSDictionary *)parameters method:POSTHttpMethod ResponArgument:responArguments];
}



+ (void)gettUrl         :(NSString *)url
        ResponArgument  :(HFHttpResponArguments *)responArguments
{
    [ [ self sharedClient] Url:url parameters:nil method:GETHttpMethod ResponArgument:responArguments];
}


#pragma mark  -

+ (void) loginRequest :(NSString *)url
         sucessRespon :(HFHttpSuccessCallBack)sucessRespon
            failRespon:(HFHttpErrorRequestCallBack)failRespon
      requestParameter:(ESRequestParameters *)requestParameter
            
{
    [self httpResponArguments].sucessRespon = sucessRespon;
    [self httpResponArguments].failRespon = failRespon;
    [self postUrl:url postArguments:requestParameter ResponArgument:[self  httpResponArguments]];
};

@end

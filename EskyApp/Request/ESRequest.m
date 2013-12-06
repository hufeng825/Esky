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
        postArguments   :(NSDictionary *)parameters
        ResponArgument  :(HFHttpResponArguments *)responArguments
{
    [ [ self  sharedClient] Url:url parameters:parameters method:POSTHttpMethod ResponArgument:responArguments];
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
    HFHttpResponArguments *arguments = NEW(HFHttpResponArguments);
    arguments.sucessRespon = sucessRespon;
    arguments.failRespon = failRespon;
    [self postUrl:url postArguments:requestParameter.arg ResponArgument:arguments];
};

@end

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

+ (HFHttpResponArguments *)httpResponArguments {
    return [[HFHttpResponArguments alloc] init];
};


+ (void)postUrl         :(NSString *)url
  postArguments   :(NSDictionary *)parameters
 responArgument  :(HFHttpResponArguments *)responArguments {
    [[self sharedClient] Url:url parameters:parameters method:POSTHttpMethod ResponArgument:responArguments];
}

+ (void)postUrl         :(NSString *)url
  postArguments   :(NSDictionary *)parameters
    uploadBlock:(HFHttpUploadCallBack)uploadBlock
 responArgument  :(HFHttpResponArguments *)responArguments {
    [[self sharedClient] Url:url parameters:parameters ResponArgument:responArguments uploadBlock:uploadBlock];
}


+ (void)gettUrl         :(NSString *)url
 responArgument  :(HFHttpResponArguments *)responArguments {
    [[self sharedClient] Url:url parameters:nil method:GETHttpMethod ResponArgument:responArguments];
}

#pragma mark --

#pragma mark  -  开始网络请求



+ (void)loginRequest :(HFHttpSuccessCallBack)sucessRespon
          failRespon:(HFHttpErrorRequestCallBack)failRespon
    requestParameter:(ESRequestParameters *)requestParameter {
    HFHttpResponArguments *arguments = NEW(HFHttpResponArguments);
    arguments.sucessRespon = sucessRespon;
    arguments.failRespon = failRespon;
    [self postUrl:requestParameter.requestPath postArguments:requestParameter.arg responArgument:arguments];
};


+ (void)registerRequest :(HFHttpSuccessCallBack)sucessRespon
             failRespon:(HFHttpErrorRequestCallBack)failRespon
         progressRespon:(HFHttpDownloadProgressCallBlock)progressRespon
       requestParameter:(ESRequestParameters *)requestParameter {
    HFHttpResponArguments *arguments = NEW(HFHttpResponArguments);
    arguments.sucessRespon = sucessRespon;
    arguments.failRespon = failRespon;
    arguments.progressBlock = progressRespon;
    [self postUrl:requestParameter.requestPath postArguments:requestParameter.arg responArgument:arguments];
}

+ (void)resetPasswordRequest :(HFHttpSuccessCallBack)sucessRespon
                  failRespon:(HFHttpErrorRequestCallBack)failRespon
            requestParameter:(ESRequestParameters *)requestParameter {
    HFHttpResponArguments *arguments = NEW(HFHttpResponArguments);
    arguments.sucessRespon = sucessRespon;
    arguments.failRespon = failRespon;
    [self postUrl:requestParameter.requestPath postArguments:requestParameter.arg responArgument:arguments];
}


@end

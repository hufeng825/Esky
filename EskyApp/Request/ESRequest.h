//
//  LogRequest.h
//  EskyApp
//
//  Created by jason on 13-12-2.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "HFHttpRequestManager.h"
#import "HFHttpRequestParameters.h"
#import "ESRequestParameters.h"

@interface ESRequest : HFHttpRequestManager




+ (void) loginRequest :(NSString *)url
         sucessRespon :(HFHttpSuccessCallBack)sucessRespon
            failRespon:(HFHttpErrorRequestCallBack)failRespon
      requestParameter:(ESRequestParameters *)requestParameter;


@end


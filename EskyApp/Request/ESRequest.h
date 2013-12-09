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

#import "ESUserModel.h"

@interface ESRequest : HFHttpRequestManager



+ (void) loginRequest :(HFHttpSuccessCallBack)sucessRespon
            failRespon:(HFHttpErrorRequestCallBack)failRespon
      requestParameter:(ESRequestParameters *)requestParameter;



+ (void) registerRequest :(HFHttpSuccessCallBack)sucessRespon
               failRespon:(HFHttpErrorRequestCallBack)failRespon
           progressRespon:(HFHttpDownloadProgressCallBlock)progressRespon
         requestParameter:(ESRequestParameters *)requestParameter
              uploadBlock:(HFHttpUploadCallBack)uploadBlock;

+ (void) registerRequest :(HFHttpSuccessCallBack)sucessRespon
               failRespon:(HFHttpErrorRequestCallBack)failRespon
           progressRespon:(HFHttpDownloadProgressCallBlock)progressRespon
         requestParameter:(ESRequestParameters *)requestParameter;

@end


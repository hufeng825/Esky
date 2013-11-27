//
//  Header.h
//  HFFrame
//
//  Created by jason on 13-4-11.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#ifndef HFFrame_Header_h
#define HFFrame_Header_h
#import "HFHttpRequestResult.h"
#import "AFHTTPRequestOperation.h"


#define HFHttp_Success_BLOCK ^(HFHttpRequestResult *result)

#define HFHttp_Fail_BLOCK ^(AFHTTPRequestOperation *operation, NSError *error)

#define HFHttp_Sucess_Respon ^(AFHTTPRequestOperation *operation, id responseObject)


#define HFHttp_DownloadProgress_BLOCK ^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)



typedef  void(^AFSucessResponBlock) (AFHTTPRequestOperation *operation, id responseObject);

typedef  void(^AFFailCallBlock)     (AFHTTPRequestOperation *operation, NSError *error);



typedef  void (^HFHttpSuccessCallBack)      (HFHttpRequestResult *result);

typedef  void (^HFHttpErrorRequestCallBack) (HFHttpErrorRequestResult *erroresult);


typedef  void (^HFHttpDownloadProgressCallBlock)(NSUInteger bytesRead,
                                                 long long totalBytesRead,
                                                 long long totalBytesExpectedToRead);




#endif

//
//  HFHttpClient.h
//  HFFrame
//
//  Created by jason on 13-4-9.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFHttpConfigure.h"
#import "HFHttpDefine.h"
#import "HFHttpRequestResult.h"
/////////////////////////////////////






@interface HFHttpResponArguments : NSObject

@property (nonatomic,copy)     HFHttpSuccessCallBack sucessRespon;

@property (nonatomic,copy)     HFHttpErrorRequestCallBack failRespon;

@property (nonatomic,copy)     HFHttpDownloadProgressCallBlock progressBlock;

@property (nonatomic,strong)   HFHttpConfigure *cachePolicy;

@property (nonatomic,strong)   id userInfo;

@end

//
//  HFHttpRequest.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//
#import "HFBaseHttpRequest.h"
//#import "HFURL.h"


@implementation HFBaseHttpRequest


-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    [self.responseSerializer setAcceptableContentTypes:
        [NSSet setWithObjects:  @"application/json",
                                @"text/json",
                                @"text/javascript",
                                @"text/plain",
                                @"text/html", nil]
     ];
    return self;
}


//非单例模式
+(HFBaseHttpRequest *)client
{
    HFBaseHttpRequest *client = [[self alloc]initWithBaseURL:nil];
    #if !__has_feature(objc_arc)
        [client autorelease];
    #endif
    return client;
}


//单例模式
+(HFBaseHttpRequest *)sharedClient
{
    static HFBaseHttpRequest *sharedHttpRequest = nil;
    static dispatch_once_t onceToken =0;
    
    dispatch_once(&onceToken, ^{
        if(!sharedHttpRequest)
            sharedHttpRequest = [[HFBaseHttpRequest alloc] initWithBaseURL:nil];

    });
    return sharedHttpRequest;
}


//因为是单例和非单例混合的初始化 暂时没有重写allocWithZone
#pragma  mark -
#pragma mark -  格式化url中的全角支付

- (NSString *)formatUrlStr:(NSString *)url
{
    NSString *urlStr=nil;//如果含有中文或者全角字符 则进行UTF-8格式化
    if ([url gotChineseCount]>0)
    {
        urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        urlStr = url;
    }
    return urlStr;
}


- (NSString*)encodeURL:(NSString *)string
{
	NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))) ;
    #if !__has_feature(objc_arc)
    [newString autorelease];
    #endif
	if (newString) {
		return newString;
	}
	return @"";
}



#pragma mark -  打印url 可以将post 请求以get 方式打印

- (void)logUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters
{
    if (parameters)
    {
        NSLog(@"post url  输出 %@?%@",urlStr,[self describeDictionary:parameters]);
    }
    else
    {
        NSLog(@"get url 输出 %@",[urlStr description]);
    }
}


#pragma mark - 网络状态改变后的一些处理
- (void)reachabilityStatusChangeBlock
{
//    //    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
//    //设置网络状态切换模式
//    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
//     {
//         switch (status)
//         {
//             case AFNetworkReachabilityStatusUnknown:
//                 NSLog(@"AFNetworkReachabilityStatusUnknown");
//                 break;
//             case AFNetworkReachabilityStatusNotReachable:
//                 NSLog(@"AFNetworkReachabilityStatusNotReachable");
//                 break;
//             case AFNetworkReachabilityStatusReachableViaWWAN:
//                 NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
//                 break;
//             case AFNetworkReachabilityStatusReachableViaWiFi:
//                 NSLog(@"AFNetworkReachabilityStatusReachableViaWiFi");
//                 break;
//                 
//             default:
//                 NSLog(@"AFNetworkReachabilityStatusUnknown");
//                 break;
//         }
//     }
//         ];
}


#pragma mark - 错误处理
//- (AFFailCallBlock )failResponHandling:(HFHttpFailCallBlock)failRespon
//{
//    //此处可以追加默认错误
//    HFHttpFailCallBlock failRespons = ^(AFHTTPRequestOperation *operation, NSError *error)
//    {
////            HFDERROR(@"网络请求错误: %@",[error description]);
//            HFAlert_T_M_BT(@"错误警告", @"网络出错，请检查您的网络设置", @"确定");
//            if (failRespon) {
//                failRespon(operation,error);
//            }
//     };
//    #if !__has_feature(objc_arc)
//    return [[failRespons copy]autorelease];
//    #else
//    return [failRespons copy];
//    #endif
//}
//


#pragma mark - 成功处理
-(AFSucessResponBlock)sucessHandling:(HFHttpSuccessCallBack)callBack
                              userInfo:(id)userInfo
{
    AFSucessResponBlock sucessRespon =  ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        HFHttpRequestResult *result = [[HFHttpRequestResult alloc]initWithData:responseObject
                                                                       request:operation.request userInfo:userInfo];
        if (callBack) {
            callBack(result);
        }
    };
    return [sucessRespon copy];
}


#pragma mark -网络失败处理

-(AFFailCallBlock)failHandling:(HFHttpErrorRequestCallBack)callBack
                      userInfo:(id)userInfo
{
    AFFailCallBlock failRespon = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        HFHttpErrorRequestResult *errorRequest = [[HFHttpErrorRequestResult alloc] initWithRequest:operation.request userInfo:userInfo];
        HFAlert_T_M_BT(@"错误警告", @"网络出错，请检查您的网络设置", @"确定");
        if (callBack) {
            callBack(errorRequest);
        }
    };
    return [failRespon copy];
}


#pragma mark - 设置缓存策略
- (void)cachePolicy:(HFHttpConfigure *)cachePolicy
            request:(NSMutableURLRequest *)request
{
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    if (!cachePolicy) {
        cachePolicy = [[HFHttpConfigure alloc]init];
    #if !__has_feature(objc_arc)
        [cachePolicy autorelease];
    #endif
    }
    [urlCache setMemoryCapacity:cachePolicy.memoryCapacity];
    [request setCachePolicy:cachePolicy.cachePolicy];
    [request setTimeoutInterval:cachePolicy.timeInterval];
}


- (void)Url:(NSString*)url
               parameters:(NSDictionary *)parameters
                   method:(HFHttpMethod)method
           ResponArgument:(HFHttpResponArguments *)responArguments

{
    if (!responArguments) {
        responArguments = [[HFHttpResponArguments alloc]init];
        #if !__has_feature(objc_arc)
        [responArguments autorelease];
        #endif
    }

    NSString *urlStr = [self formatUrlStr:url];

    //设置错误处理
    AFFailCallBlock     errorRespon = [self failHandling:responArguments.failRespon
                                            userInfo:responArguments.userInfo ];
    
    AFSucessResponBlock sucessRespon = [self sucessHandling:responArguments.sucessRespon
                                                     userInfo:responArguments.userInfo];
    

    AFHTTPRequestOperation *requestOperation ;
    
    //打印url
    [self logUrl:urlStr parameters:parameters];
    
    if (method == POSTHttpMethod)
    {
      requestOperation =  [self POST:urlStr
                          parameters:parameters
                             success:sucessRespon
                             failure:errorRespon];
    }
    else if(method == GETHttpMethod)
    {
      requestOperation = [self GET:urlStr
                        parameters:parameters
                           success:sucessRespon
                           failure:errorRespon];
    }
    [requestOperation setDownloadProgressBlock:responArguments.progressBlock];
    [self cachePolicy:responArguments.cachePolicy
              request:(NSMutableURLRequest*)requestOperation.request ];
}


- (NSString *) describeDictionary :(NSDictionary *)dict
{
    NSArray *keys;
    NSMutableString *parmURLStr = [NSMutableString string];
    NSUInteger i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        //        NSLog (@"Key: %@ for value: %@", key, value);
        [parmURLStr appendFormat:@"&%@=%@",key,value];
    }
    return parmURLStr;
}




- (void)dealloc
{
    [[self operationQueue] cancelAllOperations];
}
@end

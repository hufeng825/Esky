//
//  HHRequestResult.h
//
//  Copyright 2010 Apple Inc. All rights reserved.
//




@interface HFHttpRequestResult : NSObject

@property(nonatomic, copy) NSString *code;

@property(nonatomic, copy) NSString *message;

@property(nonatomic, copy) id data;

@property(nonatomic, copy) id Json; //网络请求返回的json

@property(nonatomic, copy) id userInfo;

@property(nonatomic, copy) NSURLRequest *request;

- (HFHttpRequestResult *)initWithData:(id)Json
                              request:(NSURLRequest *)request
                             userInfo:(id)userInfo;

- (BOOL)isSuccess;

- (BOOL)isSessionTimeoutError;

- (BOOL)shouldShowErrorMessage;

- (void)showErrorMessage;

- (void)handleErrorMessage;// show error message if should show

@end


@interface HFHttpErrorRequestResult : NSObject

@property(nonatomic, copy) NSError *error;

@property(nonatomic, copy) NSURLRequest *request;

@property(nonatomic, copy) id userInfo;


- (HFHttpErrorRequestResult *)initWithRequest:(NSURLRequest *)request error:(NSError *)error userInfo:(id)userInfo;
//@property (nonatomic,copy) 
@end
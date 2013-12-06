//
//  HHRequestResult
//
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "HFHttpRequestResult.h"


@implementation HFHttpRequestResult

#pragma mark - lifecycle

#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_userInfo release];
    [_Json release];
    [_request release];
    [_response release];
	[_code release];
    [_message release];
    [_data release];
    [super dealloc];
}
#endif

-(id)init
{
    self = [super init];
    if (self) {
        _userInfo = nil;
        _Json = nil;
        _code = nil ;
        _message = nil;
        _data = nil;
    }
    return self;
}


- (id)initWithData:(id)Json request:(NSURLRequest *)request userInfo:(id)userInfo
{
    self =[self init];
    if (self)
    {
        // Custom initializatison
        if (Json)
        {
            if ([Json isKindOfClass:[NSDictionary class]])
            {
                [self formatData:Json];
            }
            else
            {
//                HFDERROR(@"data 数据格式错误")
                NSLog(@"data 数据格式错误");
            }
        }
        else
        {
//            HFDERROR(@"data 为 NULL");
            NSLog(@"data 为 NULL");
        }
        _Json = [Json copy];
        _userInfo = [userInfo copy];
        _request = [request copy];
    }
    return self;
}
#pragma mark 格式化数据
-(void)formatData:(NSDictionary *)data
{
    self.code = [data stringForKey:@"code"];
    self.message = [data stringForKey:@"msg"] ;
    
    if ([data objectForKey:@"data"])
    {
       self.data =[data objectForKey:@"data"];
    }
    else
    {
        self.data = nil;
//        HFDINFO(@"data 为 NULL")
    }
}

#pragma mark - public methods

-(BOOL)isSuccess
{
    return (_code && [_code isEqualToString:@"0000"]);
}

// show error message if should show
- (void)handleErrorMessage
{
    if ([self shouldShowErrorMessage]) {
        [self showErrorMessage];
    }
}

-(void)showErrorMessage
{
    if (_message && _message.length > 0 ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"服务提示"
                                                            message:_message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
#if !__has_feature(objc_arc)

        [alertView release];
#endif
    }
}

- (BOOL)isSessionTimeoutError
{
    return (_code && [_code isEqualToString:@"4003"]);
}

- (BOOL)shouldShowErrorMessage
{
    return (_code && [_code isEqualToString:@"2000"]);
}
@end




@implementation HFHttpErrorRequestResult

-(id)init
{
    self = [super init];
    if (self) {
        _userInfo = nil;
        _request = nil;
        _userInfo = nil ;

    }
    return self;
}


-(HFHttpErrorRequestResult*) initWithRequest:(NSURLRequest *)request error:(NSError *)error userInfo:(id)userInfo
{
    self =[self init];
    if (self)
    {
        // Custom initializatison
        _userInfo = [userInfo copy];
        _request = [request copy];
        _error = [error copy];
    }
    return self;}


@end
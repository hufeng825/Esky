//
//  ESPublishViewController.m
//  EskyApp
//
//  Created by jason on 14-1-10.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESPublishViewController.h"
#import "FaceBoard.h"
#import "ESCommonMacros.h"
#import "NSString+Additions.h"
#import "AGCustomShareViewToolbar.h"
#import "UIView+Additions.h"

@interface ESPublishViewController ()
{
    @private
    AGCustomShareViewToolbar *_toolbar;
    __weak IBOutlet UIView *_toolbarBG;

}

@property (weak,   nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak,   nonatomic) IBOutlet UITextView *contextView;
@property (strong, nonatomic) FaceBoard *faceBoard;
@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (strong, nonatomic) UIImage *sendimage;
@property (assign, nonatomic) BOOL isKeyBoardState;
- (IBAction)ejmoBtlick:(id)sender;

@end

@implementation ESPublishViewController
@synthesize isKeyBoardState;

- (id)initWithImage:(UIImage *)image
{
    NSString *clssName = NSStringFromClass([self class]);
    
    self = [super initWithNibName:clssName bundle:Nil];
    if (self) {
        _sendimage = image;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    _faceBoard = [[FaceBoard alloc]init];
    isKeyBoardState = YES;
    if (self.isViewLoaded) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            __block UIImage *img =  [_sendimage compressedImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _sendImageView.image = img;
            });
        });
    }
    [self updateWordCount];
    
    _toolbar = [[AGCustomShareViewToolbar alloc] initWithFrame:CGRectMake(42, 168, _toolbarBG.width - 40, _toolbarBG.height)];
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_bgScrollView addSubview:_toolbar];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    double delayInSeconds = .3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.contextView becomeFirstResponder];
    });
}

- (void)sendMessage
{
    if (!TTIsStringWithAnyText(_contextView.text)) {
        HFAlert(@"输入一些文字吧");
        return;
    }
    [self publishButtonClickHandler:nil];
}


- (void)stretchScrollViewContext
{
    [self.bgScrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+50.f) ];
}

- (void)resetScrollViewContext
{
    [self.bgScrollView setContentSize:self.view.frame.size];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self resetScrollViewContext];
    
}
- (IBAction)buttonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;

}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateWordCount];
}

- (void)updateWordCount
{
    NSInteger count = 140 - [_contextView.text lengthToInt];
    _wordCountLabel.text = [NSString stringWithFormat:@"%d", count];
    
    if (count < 0)
    {
        _wordCountLabel.textColor = [UIColor redColor];
    }
    else
    {
        _wordCountLabel.textColor = RGB(66, 66, 66);
    }
}

#pragma mark - Share

- (id<ISSAuthOptions>) creatauthOptions
{
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    return authOptions;
}


- (void)sendImageContent:(id<ISSContent>)content
{
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiSession
               authOptions:[self creatauthOptions]
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"知道了"
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];
}


- (void)sendTimelineImageContent:(id<ISSContent>)content
{
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiTimeline
               authOptions:[self creatauthOptions]
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                            [self dismissViewControllerAnimated:YES completion:nil];

                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            HFAlert(@"分享失败,错误码:%d,错误描述:%@",[error errorCode],  [error errorDescription]);

                            if ([error errorCode] == -22003)
                            {
                            }
                        }
                    }];
}


- (void)sendToQQSpaceImageContent:(id<ISSContent>)publishContent
{
    [ShareSDK shareContent:publishContent
                      type:ShareTypeQQSpace
               authOptions:[self creatauthOptions]
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSPublishContentStateSuccess)
        {
            NSLog(@"发表成功");
        }
        else if (state == SSPublishContentStateFail)
        {
            NSLog(@"发布失败!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
        }
    }];
}

- (void)publishButtonClickHandler:(id)sender
{
    NSArray *selectedClients = [_toolbar selectedClients];
    if ([selectedClients count] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请选择要发布的平台!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles: nil];
        [alertView show];        
        return;
    }
    
    id<ISSContent> publishContent = [ShareSDK content:_contextView.text
                                       defaultContent:nil
                                                image:[ShareSDK jpegImageWithImage:_sendImageView.image quality:1]
                                                title:@"分享"
                                                  url:@"http://www.esky.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeImage];
    
    NSMutableDictionary *item;
    for (int i =0; i< [selectedClients count]; i++) {
        item = [selectedClients objectAtIndex:i];
        ShareType shareType = [[item objectForKey:@"type"] integerValue];
        BOOL selected =  [[item objectForKey:@"selected"] boolValue];
        if (selected) {
            switch (shareType) {
                case ShareTypeQQSpace:
                    [self sendToQQSpaceImageContent:publishContent];
                    break;
                case ShareTypeWeixiSession:
                    [self sendImageContent: publishContent];
                    break;
                case ShareTypeWeixiTimeline:
                    [self sendTimelineImageContent:publishContent];
                    break;
                default:
                    break;
            }
        }
    }

    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in selectedClients) {
        if ([[item objectForKey:@"type"] integerValue] != ShareTypeWeixiSession &&
            [[item objectForKey:@"type"] integerValue] != ShareTypeWeixiTimeline &&
            [[item objectForKey:@"type"] integerValue] != ShareTypeQQSpace
            ) {
            [array addObject: [item objectForKey:@"type"] ];
        }
    }
    
    BOOL needAuth = NO;
    if ([array count] == 1)
    {
        ShareType shareType = [ [[selectedClients objectAtIndex:0] objectForKey:@"type"]  integerValue];
        if (![ShareSDK hasAuthorizedWithType:shareType])
        {
            needAuth = YES;
            [ShareSDK getUserInfoWithType:shareType
                              authOptions:[self creatauthOptions]
                                   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                       if (result)
                                       {
                                           //分享内容
                                           [ShareSDK oneKeyShareContent:publishContent
                                                              shareList:array
                                                            authOptions:[self creatauthOptions]
                                                          statusBarTips:YES
                                                                 result:nil];
                                           
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       }
                                   }];
        }
    }
    
    if (!needAuth)
    {
        //分享内容
        [ShareSDK oneKeyShareContent:publishContent
                           shareList:array
                         authOptions:[self creatauthOptions]
                       statusBarTips:YES
                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end){
                                  if(state ==  SSPublishContentStateSuccess)
                                  {
                                      NSLog(@"分享成功");
                                      [self dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }
                                  else if(state ==  SSPublishContentStateFail)
                                  {
                                      HFAlert(@"分享失败,错误码:%d,错误描述:%@",[error errorCode],  [error errorDescription]);
                                  }

                              }
         ];
        
    }
}


- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
    
    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = nil;
    
    UILabel *titleView = (UILabel *)viewController.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        viewController.navigationItem.titleView = titleView;
    }
    titleView.text = @"时尚先生认证";
    titleView.textColor = [UIColor blackColor];
    titleView.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0];
    [titleView sizeToFit];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ejmoBtlick:(id)sender {
    isKeyBoardState = !isKeyBoardState;
    [self.contextView resignFirstResponder];
    if (isKeyBoardState) {
        _faceBoard.inputTextView = self.contextView;
        self.contextView.inputView = _faceBoard ;
    }else{
        _faceBoard.inputTextView = nil;
        self.contextView.inputView = nil ;
    }
    [self.contextView becomeFirstResponder];
}
@end

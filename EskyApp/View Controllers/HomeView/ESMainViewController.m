//
//  FAViewController.m
//  FAFrame
//
//  Created by jason on 13-10-22.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESMainViewController.h"

#import "ESConfig.h"


#import "ESLoginViewController.h"


@interface ESMainViewController ()
@property (weak, nonatomic) IBOutlet UIWebImageView *testimg;

@end

@implementation ESMainViewController

- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
//    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];



    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = nil;

    viewController.navigationItem.leftBarButtonItem  = Nil;


    UIButton *button                                 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [viewController.view addSubview:button];

 }


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.navigationController.modalTransitionStyle   = UIModalTransitionStylePartialCurl;

    double delayInSeconds                            = 2.0;
    dispatch_time_t popTime                          = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        [_testimg setImageWithURLStr:@"http://hufeng825.github.io/img/hufeng825.jpg" placeholderImage:_testimg.image success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

    CATransition *transtion                          = [CATransition animation];
    transtion.duration                               = 2;
            [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [transtion setType:@"oglFlip"];

            [transtion setSubtype:kCATransitionFromRight];

            [_testimg.layer addAnimation:transtion forKey:@"transtionKey"];
            [_testimg setImage:image];
        } failure:
         nil]
        ;
    });
//


    UIView *view1                                    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    view1.backgroundColor                            = [UIColor redColor];

    UIView *view2                                    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    view2.backgroundColor                            = [UIColor yellowColor];



//    double delayInSeconds = 2.0;
//
//    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
//
//    [view3 addSubview:view1];
//    [view3 addSubview:view2];
//
//
//    [self.view addSubview:view3];
//
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//
//
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:1];
//        [UIView setAnimationBeginsFromCurrentState:NO];
//        [UIView transitionFromView:view2 toView:view1 duration:3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
//        [UIView commitAnimations];
//    });
//




//    HFHttpResponArguments *responArgument =  [[HFHttpResponArguments alloc]init];
//    responArgument.sucessRespon = HFHttp_Success_BLOCK
//    {
//        NSLog(@"%@",result.Json);
//    };
//
//
//
//
//
//    NSString *url = @"http://api.t.sina.com.cn/provinces.json";
//    NSLog(@"%lu",(unsigned long)[url gotChineseCount]);
//
//    [self gettUrl:url ResponArgument:responArgument];
//
//    url = @"http://httpbin.org/post";



//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//
////        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
//
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
//                                           defaultContent:@"默认分享内容，没内容时显示"
//                                                    image:[ShareSDK imageWithPath:nil]
//                                                    title:@"你好"
//                                                      url:@"http://hufeng.cn"
//                                              description:@"这是一条测试信息"
//                                                mediaType:SSPublishContentMediaTypeNews];
//
//        id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//
//                                                             allowCallback:NO
//
//                                                             authViewStyle:SSAuthViewStyleFullScreenPopup
//
//                                                              viewDelegate:self
//
//                                                   authManagerViewDelegate:self];
//
//        NSArray *shareList = [ShareSDK getShareListWithType:
//                              ShareTypeSinaWeibo,
//                              ShareTypeWeixiSession,
//                              ShareTypeWeixiTimeline,
//                              ShareTypeTencentWeibo,
//                              ShareTypeQQ,
//                              ShareTypeCopy,
//                              nil];
//
//
//        //定制一键分享列表
//        NSArray *oneKeyShareList = [ShareSDK getShareListWithType:
//                                    ShareTypeSinaWeibo,
//                                    ShareTypeTencentWeibo,
//                                    nil];
//
//        id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"测试"
//                                                                  oneKeyShareList:oneKeyShareList
//                                                                   qqButtonHidden:NO
//                                                            wxSessionButtonHidden:NO
//                                                           wxTimelineButtonHidden:NO
//                                                             showKeyboardOnAppear:YES                                                                shareViewDelegate:nil
//                                                              friendsViewDelegate:nil
//                                                            picViewerViewDelegate:nil];
//
//
//
//
//        [ShareSDK showShareActionSheet:nil
//                             shareList:shareList
//                               content:publishContent
//                         statusBarTips:YES
//                           authOptions:authOptions
//                          shareOptions: shareOptions
//                                result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                    if (state == SSPublishContentStateSuccess)
//                                    {
//                                        NSLog(@"分享成功");
//                                    }
//                                    else if (state == SSPublishContentStateFail)
//                                    {
//                                        NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                    }
//                                }];
//
//
//    });
//
    [self thirdLog];

    NSLog(@"%@",[[ESConfig globalConfig]userAgent]);




    ESLoginViewController *lg                        = [[ESLoginViewController alloc]init];
    [self.navigationController presentViewController:lg animated:YES completion:nil];

}



-(void)thirdLog
{

    UIButton *loginBtn                               = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"title" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor redColor]];
    loginBtn.frame                                   = CGRectMake((self.view.frame.size.width - 173.0) / 2, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    loginBtn.autoresizingMask                        = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [loginBtn addTarget:self action:@selector(loginBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)loginBtnClickHandler:(id)sender
{
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//
//                                                         allowCallback:YES
//
//                                                         authViewStyle:SSAuthViewStyleModal
//
//                                                          viewDelegate:self
//
//                                               authManagerViewDelegate:self];
//
//    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:authOptions result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
//    {
//       if (result)
//       {
//
//           //创建分享内容
//
//           id<ISSContent> publishContent = [ShareSDK content:@"content"
//                                              defaultContent:@"ceshi"
//                                                       image:[ShareSDK imageWithPath:nil]
//                                                       title:nil
//                                                         url:nil
//                                                 description:nil
//                                                   mediaType:SSPublishContentMediaTypeText];
//           [ShareSDK shareContent:publishContent
//                             type:ShareTypeSinaWeibo
//                      authOptions:nil
//                    statusBarTips:YES
//                           result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                               if (state == SSPublishContentStateSuccess)
//                               {
//                                   NSLog(@"分享成功");
//                               }
//                               else if (state == SSPublishContentStateFail)
//                               {
//                                   NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode],  [error errorDescription]);
//                               }
//                           }];
//
//       }
//
//   }];
//


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

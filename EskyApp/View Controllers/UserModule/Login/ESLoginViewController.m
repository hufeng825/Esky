//
//  ESLoginViewController.m
//  Esquire
//
//  Created by jason on 13-11-19.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESLoginViewController.h"

#import "UIViewController+KNSemiModal.h"
#import "ESRegisterViewController.h"
#import "ESModifyPassWordViewController.h"

#import "ESRequest.h"


@interface ESLoginViewController () {

    __weak IBOutlet UIScrollView *bgScrollView;
}

@end

@implementation ESLoginViewController
#define EmailTag 1001
#define MMTag 1002


#pragma mark themeChanged

- (void)themeChanged {
    [super themeChanged];
    [self.loginBt setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"bt.png"] forState:UIControlStateNormal];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [bgScrollView setContentSize:CGSizeMake(self.view.width, self.view.height + 15)];
    [self initInputs];

    UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singletap setNumberOfTapsRequired:1];
    singletap.delegate = self;
    [bgScrollView addGestureRecognizer:singletap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self viewEndEdit];
}

- (void)initInputs {
    [self.logoNameInput setData:nil placeStr:@"请输入您的注册邮箱" delegate:self];
    [self.mmInput setData:nil placeStr:@"请输入您的密码" delegate:self];

    [self.logoNameInput.textField setReturnKeyType:UIReturnKeyNext];
    [self.mmInput.textField setReturnKeyType:UIReturnKeyDone];

    [self.logoNameInput.textField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.mmInput.textField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.mmInput setSecureTextEntry:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (void)handleSingleTap:(id)sender {
    [self viewEndEdit];
}


- (void)keyboarShow:(FAInputView *)inputView {
    if (is4InchScreen()) {
        [self setBgContentOffsetAnimation:140];
    }
    else {
        [self setBgContentOffsetAnimation:200];
    }
}


//因为runloop原因 所以setContentOffset animation 有时候卡顿 所以重写此方法
- (void)setBgContentOffsetAnimation:(CGFloat)OffsetY {
    [UIView animateWithDuration:.5 animations:^{
        bgScrollView.contentOffset = CGPointMake(0, OffsetY);
    }];
}

- (void)viewEndEdit {
    [self.view endEditing:YES];
    [self setBgContentOffsetAnimation:0];
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(FAInputView *)textField {
    [self keyboarShow:textField];
    return YES;
}


- (BOOL)textFieldShouldReturn:(FAInputView *)textField {
    if (textField.tag == EmailTag) {
        [self.mmInput becomeFirstRespond];
    }
    else if (textField.tag == MMTag) {
        [self.view endEditing:YES];
        [self setBgContentOffsetAnimation:0];
        [self login];
    }
    return YES;
}


- (BOOL)checkParameter {
    if (!TTIsStringWithAnyText(_logoNameInput.text)) {
        [self showWarning:@"请输入您的用户名"];
        [_logoNameInput setIsError:YES];
    }
    else if (!TTIsStringWithAnyText(_mmInput.text)) {
        [self showWarning:@"密码输入错误"];
        [_mmInput setIsError:YES];
    }
    else {
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark Click

- (IBAction)resetPassClick:(id)sender {
    [self viewEndEdit];
    ESModifyPassWordViewController *semiVC = [[ESModifyPassWordViewController alloc] initWithNibName:@"ESModifyPassWordViewController" bundle:nil];
    [self presentSemiViewController:semiVC withOptions:@{
            KNSemiModalOptionKeys.pushParentBack : @(YES),
            KNSemiModalOptionKeys.animationDuration : @(.5),
            KNSemiModalOptionKeys.shadowOpacity : @(0.5)}];
}

- (IBAction)regesitClick:(id)sender {
    ESRegisterViewController *rg = [[ESRegisterViewController alloc] init];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:rg];
    [self presentViewController:nv animated:YES completion:Nil];
}

- (IBAction)loginClick:(id)sender {
    [self login];
}

- (IBAction)qqloginClick:(id)sender {
    id <ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                          allowCallback:YES
                                                          authViewStyle:SSAuthViewStyleModal
                                                           viewDelegate:self
                                                authManagerViewDelegate:self];
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:authOptions result:^(BOOL result, id <ISSPlatformUser> userInfo, id <ICMErrorInfo> error) {
        if (result) {
            HFAlert(@"登录成功");
            [self goBack];
        }
    }];


}

- (IBAction)sinaLoginClick:(id)sender {
    id <ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                          allowCallback:YES
                                                          authViewStyle:SSAuthViewStyleModal
                                                           viewDelegate:self
                                                authManagerViewDelegate:self];
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:authOptions result:^(BOOL result, id <ISSPlatformUser> userInfo, id <ICMErrorInfo> error) {
        if (result) {
            //创建分享内容
            id <ISSContent> publishContent = [ShareSDK content:@"content"
                                                defaultContent:@"ceshi"
                                                         image:[ShareSDK imageWithPath:nil]
                                                         title:nil
                                                           url:nil
                                                   description:nil
                                                     mediaType:SSPublishContentMediaTypeText];
            [ShareSDK shareContent:publishContent
                              type:ShareTypeSinaWeibo
                       authOptions:nil
                     statusBarTips:YES
                            result:^(ShareType type, SSResponseState state, id <ISSPlatformShareInfo> statusInfo, id <ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess) {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail) {
                                    //                                     NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode],  [error errorDescription]);
                                }
                            }];
        }
    }];
}


#pragma mark


- (void)login {
    if ([self checkParameter]) {
        ESRequestParameters *postObject = [ESRequestParameters requestLoginParametersWithUsername:_logoNameInput.text email:_logoNameInput.text passWord:[_mmInput.text stringFromMD5]];
        __weak __typeof (self) weakSelf = self;
        [ESRequest loginRequest:^(HFHttpRequestResult *result) {
            NSLog(@"");
            if ([result isSuccess]) {
                ESUserModel *user = [ESUserModel objectFromJSONObject:result.data mapping:nil];
                [result showErrorMessage];
                [weakSelf goBack];
            } else {
                [result showErrorMessage];
            }
        }            failRespon:^(HFHttpErrorRequestResult *erroresult) {
            NSLog(@"");
        }      requestParameter:postObject];
    }
}


- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType {
    //    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
    NSString *logTitleStr;
    if (shareType == ShareTypeSinaWeibo) {
        logTitleStr = @"新浪私享家登录";
    } else if (shareType == ShareTypeQQSpace) {
        logTitleStr = @"QQ私享家登录";
    }

    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = nil;
    viewController.title = logTitleStr;

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [viewController.view addSubview:button];

}

- (void)dealloc {
    NSLog(@"###########");
}

@end

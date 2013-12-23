//
//  ESRegisterViewController.m
//  Esquire
//
//  Created by jason on 13-11-18.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRegisterViewController.h"
#import "QiniuPutPolicy.h"
#import "PECropViewController.h"

static NSString *QiniuAccessKey = @"Kqq_hZ-Ck1SepnkIlF9SISCI4MZCyiQkRblLv4Q_";
static NSString *QiniuSecretKey = @"9zE3jpWBDBQf98-hsy8-52e7Sowe1DbdJtwrAHz-";
static NSString *QiniuBucketName = @"hufeng";

@interface ESRegisterViewController () {
    NSUInteger selectedTextFieldTag;
    MBProgressHUD *HUD;
    QiniuSimpleUploader *uploader;
    NSString *headUrlStr;
    BOOL isUploading;
    BOOL isNotificationRegister;
}

@property(nonatomic, copy) NSString *imageReferenceURL;


@end

@implementation ESRegisterViewController
@synthesize imageReferenceURL;
#define NumTextFields 3
#define TextFieldBeginTag 100

#define EmailTag 1000
#define MMTag 1001
#define VMMTag 1002
#define NickNameTag 1003


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"用户注册";


    [self.bgScrollView setContentSize:CGSizeMake(self.view.width, self.view.height + 10)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];

    [self.headIconImageView.singleTap addTarget:self action:@selector(BtClick)];
    [self initInputs];


    UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singletap setNumberOfTapsRequired:1];
    singletap.delegate = self;
    [self.bgScrollView addGestureRecognizer:singletap];

    isUploading = NO;
    isNotificationRegister = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (void)handleSingleTap:(id)sender {
    [self setBgContentOffsetAnimation:0];
    [self.view endEditing:YES];
}


- (void)initInputs {
    [self.emailInput setData:nil placeStr:@"请输入您的邮箱" delegate:self];
    [self.mmInput setData:nil placeStr:@"请输入4-12位密码" delegate:self];
    [self.verifyInput setData:nil placeStr:@"再次确认密码" delegate:self];
    [self.nickNameInput setData:nil placeStr:@"请输入您的昵称" delegate:self];

    [self.emailInput.textField setReturnKeyType:UIReturnKeyNext];
    [self.mmInput.textField setReturnKeyType:UIReturnKeyNext];
    [self.verifyInput.textField setReturnKeyType:UIReturnKeyNext];
    [self.nickNameInput.textField setReturnKeyType:UIReturnKeyGo];

    [self.emailInput.textField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.mmInput.textField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.verifyInput.textField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.nickNameInput.textField setKeyboardType:UIKeyboardTypeNamePhonePad];

    [self.mmInput setSecureTextEntry:YES];
    [self.verifyInput setSecureTextEntry:YES];

    if (!is4InchScreen()) {
        [self.emailInput setFontSize:17];
        [self.mmInput setFontSize:17];
        [self.verifyInput setFontSize:17];
        [self.nickNameInput setFontSize:17];
    }
}


- (void)BtClick {
    [self.view endEditing:YES];
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        ipc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    }
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:Nil];
}


- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    self.headIconImageView.image = croppedImage;
    [controller dismissViewControllerAnimated:YES completion:NULL];
    double delayInSeconds = 2.5;
    __weak __typeof (self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [weakSelf uploadContent];
    });
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSString *peferenceURL = [(NSURL *) [info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
        self.headIconImageView.image = image;
        self.imageReferenceURL = peferenceURL;
    }
    else if ([mediaType isEqualToString:@"public.movie"]) {
        [self showWarning:@"暂不支持视频格式头像"];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:nil];
    }];
}

#pragma mark -

- (IBAction)openEditor:(id)sender {
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.cropAspectRatio = 1;
    controller.keepingCropAspectRatio = YES;
    controller.image = self.headIconImageView.image;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:NULL];
}


#pragma mark themeChanged

- (void)themeChanged {
    [super themeChanged];

    [self.registButton setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"bt.png"] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//因为runloop原因 所以setContentOffset animation 有时候卡顿 所以重写此方法
- (void)setBgContentOffsetAnimation:(CGFloat)OffsetY {
    if (self.bgScrollView.contentOffset.y != OffsetY) {
        [UIView animateWithDuration:.5 animations:^{
            self.bgScrollView.contentOffset = CGPointMake(0, OffsetY);
        }];

    }
}


- (void)keyboarShow:(FAInputView *)inputView {
    [self setBgContentOffsetAnimation:175];
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(FAInputView *)textField {
    [self keyboarShow:textField];
    if (textField.tag == MMTag && TTIsStringWithAnyText(textField.text)) {
        [self.verifyInput resetErrorState];
    } else if (textField.tag == VMMTag && TTIsStringWithAnyText(textField.text)) {
        [self.mmInput setIsError:NO];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(FAInputView *)textField {
    if (textField.tag == EmailTag) {
        [self.mmInput becomeFirstRespond];
    }
    else if (textField.tag == MMTag) {
        [self.verifyInput becomeFirstRespond];
    }
    else if (textField.tag == VMMTag) {
        [self.nickNameInput becomeFirstRespond];
        if (!is4InchScreen()) {
            [self.bgScrollView setContentOffset:CGPointMake(0, 230) animated:YES];
        }
    }
    else if (textField.tag == NickNameTag) {
    }
    [self registerClicked:nil];
    return YES;
}

- (void)textFieldDidEndEditing:(FAInputView *)textField {
    //如果用户没输入则不进行校验
    if (!TTIsStringWithAnyText(textField.text)) {
        return;
    }
    if (textField.tag == EmailTag
            && ![textField.text validateEmailAddress]) {
        [self showWarning:@"邮箱格式错误"];
        [textField setIsError:YES];
        return;
    }
    if (textField.tag == MMTag) {
        if (![textField.text validatePassWord]) {
            [self showWarning:@"密码格式错误"];
            [_mmInput setIsError:YES];
            return;
        }
    }
    if (textField.tag == VMMTag) {
        if (![textField.text isEqualToString:_mmInput.text]) {
            [self showWarning:@"密码不匹配啊"];
            [_verifyInput setIsError:YES];
            return;
        } else if (_mmInput.isError) {
            [_verifyInput setIsError:YES];
            return;
        }
    }
    [textField setIsError:NO];
}

- (BOOL)checkParameter {
    if (!TTIsStringWithAnyText(imageReferenceURL)) {
        [self setBgContentOffsetAnimation:0];
        [self showWarning:@"设置一个头像吧"];
        [self.view endEditing:YES];
    }
    else if (![_emailInput.text validateEmailAddress]) {
        [self showWarning:@"邮箱格式错误"];
        [_emailInput setIsError:YES];
    }
    else if (![_mmInput.text validatePassWord] || ![_mmInput.text isEqualToString:_verifyInput.text]) {
        [self showWarning:@"密码输入错误"];
        [_verifyInput setIsError:YES];
        [_mmInput setIsError:YES];
    }
    else if (!TTIsStringWithAnyText(_nickNameInput.text)) {
        [self showWarning:@"昵称输入错误"];
        [_nickNameInput setIsError:YES];
    }
    else {
        return YES;
    }
    return NO;
}

#pragma mark Click

- (void)registerRequest {
    if ([self checkParameter]) {
        __weak __typeof (self) weakSelf = self;
        ESRequestParameters *parameters = [ESRequestParameters requestRegisterParametersWithUserName:@"" email:_emailInput.text nickName:_nickNameInput.text avatar:headUrlStr password:[_mmInput.text stringFromMD5]];
        [ESRequest registerRequest:^(HFHttpRequestResult *result) {
            NSLog(@"%@", result.Json);
            if ([result isSuccess]) {
                HFAlert_T_M_BT(result.message, @"注册成功", @"ok");
                [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            } else {
                [result showErrorMessage];
            }
        }               failRespon:^(HFHttpErrorRequestResult *erroresult) {

        }           progressRespon:nil requestParameter:parameters];
    }
}


#pragma mark 上传图片到七牛服务器

- (void)uploadContent {
    //obtaining saving path
    if (TTIsStringWithAnyText(imageReferenceURL)) {
        //Optionally for time zone conversions
        NSString *key = [NSString stringWithFormat:@"%@%@", [NSString makeUniqueString], @".jpg"];
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:key];
        NSData *imageData = UIImageJPEGRepresentation(_headIconImageView.image, 1);
        [imageData writeToFile:filePath atomically:YES];
        [self uploadFile:filePath bucket:QiniuBucketName key:key];
        isUploading = YES;
    }

}

- (NSString *)tokenWithScope:(NSString *)scope {
    QiniuPutPolicy *policy = [QiniuPutPolicy new];
    policy.scope = scope;
    return [policy makeToken:QiniuAccessKey secretKey:QiniuSecretKey];
}


- (void)uploadFile:(NSString *)filePath bucket:(NSString *)bucket key:(NSString *)key {

    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        uploader = [QiniuSimpleUploader uploaderWithToken:[self tokenWithScope:bucket]];
        uploader.delegate = self;
        [uploader uploadFile:filePath key:key extra:nil];
    }
}

// Progress updated.
- (void)uploadProgressUpdated:(NSString *)filePath percent:(float)percent {
    NSString *message = [NSString stringWithFormat:@"Progress of uploading %@ is: %.2f%%", filePath, percent * 100];
    NSLog(@"%@", message);

}

// Upload completed successfully.
- (void)uploadSucceeded:(NSString *)filePath ret:(NSDictionary *)ret {
    NSString *hash = [ret stringForKey:@"hash"];
    NSString *message = [NSString stringWithFormat:@"Successfully uploaded %@ with hash: %@", filePath, hash];
    [self clearCache:filePath];
    NSString *urlStr = [NSString stringWithFormat:@"http://%@.qiniudn.com/%@", QiniuBucketName, [ret stringForKey:@"key"]];
    NSLog(@"%@", message);
    headUrlStr = urlStr;
    isUploading = NO ;
    if (isNotificationRegister) {
        [self registerRequest];
    }
}

- (void)clearCache:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL removed = [fileManager removeItemAtPath:filePath error:&error];
    if (removed == NO) {
        NSLog(@"removed ==NO");
    }
    if (error) {
        NSLog(@"%@", [error description]);
    }
}

- (void)uploadFailed:(NSString *)filePath error:(NSError *)error {
    NSString *message = @"";

    // For first-time users, this is an easy-to-forget preparation step.
    if ([QiniuAccessKey hasPrefix:@"<Please"]) {
        message = @"Please replace kAccessKey, kSecretKey and kBucketName with proper values. These values were defined on the top of QiniuViewController.m";
    } else {
        message = [NSString stringWithFormat:@"Failed uploading %@ with error: %@", filePath, error];
    }
    ESDERROR(@"%@", message);
    [self showWarning:@"头像上传失败"];
    headUrlStr = nil;
    isUploading = NO;
}


#pragma mark loading



#pragma mark 注册按钮点击

- (IBAction)registerClicked:(id)sender {
    [self handleSingleTap:nil];
    if (!isUploading) {
        //如果正在上传头像没有在上传状态执行创建帐号
        isNotificationRegister = NO;
        [self registerRequest];
    } else {
        //如果正在上传头像则设置通知表示告诉上传成功后执行创建帐号
        isNotificationRegister = YES;
    }

}

- (void)dealloc {
    uploader.delegate = nil;
}
@end

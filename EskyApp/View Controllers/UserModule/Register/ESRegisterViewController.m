//
//  ESRegisterViewController.m
//  Esquire
//
//  Created by jason on 13-11-18.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESRegisterViewController.h"


@interface ESRegisterViewController ()
{
    NSUInteger selectedTextFieldTag;
    UIImage *avatarImage;
    MBProgressHUD *HUD;
}
@end

@implementation ESRegisterViewController

#define NumTextFields 3
#define TextFieldBeginTag 100

#define EmailTag 1000
#define MMTag 1001
#define VMMTag 1002
#define NickNameTag 1003


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"用户注册";
    
    
    [self.bgScrollView setContentSize:CGSizeMake(self.view.width, self.view.height+10)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonSystemItemStop  target:self action:@selector(goBack)];
    
    [self.headIconImageView.singleTap addTarget:self action:@selector(BtClick)];
    [self initInputs];

    
    UITapGestureRecognizer *  singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singletap setNumberOfTapsRequired:1];
    singletap.delegate = self;
    [self.bgScrollView addGestureRecognizer:singletap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
        return YES;
}
-(void)handleSingleTap:(id)sender
{
    [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
}



-(void)initInputs
{
    [self.emailInput setData:nil placeStr: @"请输入您的邮箱" delegate:self];
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
    
    if (!is4InchScreen()) {
        [self.emailInput setFontSize:17];
        [self.mmInput setFontSize:17];
        [self.verifyInput setFontSize:17];
        [self.nickNameInput setFontSize:17];
    }
}




-(void)BtClick
{
    [self.view endEditing:YES];
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        ipc.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        ipc.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    }
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:Nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        // UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        __block UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            image = [image compressedImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                self.headIconImageView.image = image;
            });
        });
    }
    else if ([mediaType isEqualToString:@"public.movie"]){
        [self showWarning:@"暂不支持视频格式头像"];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark themeChanged

-(void)themeChanged
{
    [super themeChanged];
    
    [self.registButton setBackgroundImage:[[FAThemeManager sharedManager]themeImageWithName:@"bt.png"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//因为runloop原因 所以setContentOffset animation 有时候卡顿 所以重写此方法
-(void)setBgContentOffsetAnimation:(CGFloat )OffsetY
{
    [UIView animateWithDuration:.5 animations:^{
        self.bgScrollView.contentOffset = CGPointMake(0, OffsetY);
    }];
}


-(void)keyboarShow:(FAInputView *)inputView
{
    [self setBgContentOffsetAnimation:180];
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(FAInputView *)textField
{
    [self keyboarShow:textField];
    if (textField.tag == VMMTag) {
        [_mmInput setIsError:NO];
    }
    return YES;
}


-(BOOL)textFieldShouldReturn:(FAInputView *)textField
{
    if (textField.tag == EmailTag) {
        [self.mmInput becomeFirstResponder];
      
    }
    else if(textField.tag == MMTag){
        [self.verifyInput becomeFirstResponder];
    }
    else if(textField.tag == VMMTag){
        [self.nickNameInput becomeFirstResponder];
        if (!is4InchScreen()){
        [self.bgScrollView setContentOffset:CGPointMake(0, 230) animated:YES];
        }
    }
    else if(textField.tag == NickNameTag){
    }
    [self checkParameter];
    return YES;
}

- (void)textFieldDidEndEditing:(FAInputView *)textField
{
    if (textField.tag ==EmailTag
        && ![textField.text validateEmailAddress]
        ) {
        [self showWarning:@"邮箱格式错误"];
        [textField setIsError:YES];
    }
    else if (textField.tag == MMTag) {
        if(![textField.text validatePassWord]){
            [self showWarning:@"密码格式错误"];
            [_mmInput setIsError:YES];
        }
    }
    else if (textField.tag == VMMTag){
     if(![textField.textField.text isEqualToString:_mmInput.textField.text]){
         [self showWarning:@"密码不匹配啊"];
         [_mmInput setIsError:YES];
         [_verifyInput setIsError:YES];
      }
    }
}

-(BOOL) checkParameter
{
    if (![_emailInput.text validateEmailAddress]) {
        [self showWarning:@"邮箱格式错误"];
        [_emailInput setIsError:YES];
    }
    else if(![_mmInput.text validatePassWord] || ![_mmInput.text isEqualToString:_verifyInput.text]){
        [self showWarning:@"密码输入错误"];
        [_mmInput setIsError:YES];
    }
    else if (!TTIsStringWithAnyText(_nickNameInput.text)){
        [self showWarning:@"昵称输入错误"];
        [_nickNameInput setIsError:YES];
    }
    else{
        return YES;
    }
    return NO;
}

-(void) registerRequest
{
    if([self checkParameter])
    {
        ESRequestParameters *parameters = [ESRequestParameters requestRegisterParametersWithEmail:_emailInput.text userName:_mmInput.text nickName:_nickNameInput.text avatar:nil password:_mmInput.text];
        NSData *imageData = UIImageJPEGRepresentation(_headIconImageView.image, 0.5);
        [parameters setData:imageData forKey:@"avatar"];
        //[self createLoading];
        
    [ESRequest registerRequest:^(HFHttpRequestResult *result) {
        
    } failRespon:^(HFHttpErrorRequestResult *erroresult) {
        
    } progressRespon:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"%lld",totalBytesRead);
    } requestParameter:parameters];
        
//        [ESRequest registerRequest:^(HFHttpRequestResult *result) {
//            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]];
//            [HUD showWhileExecuting:@selector(showProgressTask) onTarget:self withObject:nil animated:YES];
//
//        } failRespon:^(HFHttpErrorRequestResult *erroresult) {
//            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]];
//            HUD.labelText = @"failed" ;
//            [HUD showWhileExecuting:@selector(showProgressTask) onTarget:self withObject:nil animated:YES];
//
//        } progressRespon:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
//            HUD.progress = percentDone;
//            HUD.labelText = [NSString stringWithFormat:@"%f",percentDone];
//        } requestParameter:parameters uploadBlock:^(id<HFMultipartFormData> formData) {
//            NSData *imageData = UIImageJPEGRepresentation(_headIconImageView.image, 0.5);
//            [formData appendPartWithFormData:imageData  name:@"avatar" ];
//        }];
    }
}

#pragma mark loading
-(void) createLoading
{
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        HUD.removeFromSuperViewOnHide = YES;
        // Set determinate mode
        HUD.mode = MBProgressHUDModeAnnularDeterminate;
        
        HUD.labelText = @"创建帐号ing";
        
        // myProgressTask uses the HUD instance to update progress
//        [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)showProgressTask {
	// This just increases the progress indicator in a loop
		usleep(15000);
}


#pragma mark 注册按钮点击

- (IBAction)registerClicked:(id)sender {
    [self registerRequest];
}
@end

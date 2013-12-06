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
    
    [self.bgScrollView setContentSize:CGSizeMake(self.view.width, self.view.height+10)];


    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.headIconImageView setImage:[UIImage imageNamed:@"icon_qq.png"]];
    });

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
    [self.mmInput setData:nil placeStr:@"请输入您的密码" delegate:self];
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
}




-(void)BtClick
{
    [self.view endEditing:YES];
    [[FAThemeManager sharedManager] setThemeName:@"man"];
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        ipc.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        ipc.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:ipc.sourceType];
    }
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:Nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        // UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.headIconImageView.image = image;
    }
    else if ([mediaType isEqualToString:@"public.movie"]){
        HFAlert(@"暂不支持视频格式头像");
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
    return YES;
}


-(BOOL)textFieldShouldReturn:(FAInputView *)textField
{
    if (textField.tag == EmailTag) {
        [self.mmInput becomeFirstResponder];
      
    }
    else if(textField.tag == MMTag)
    {
        [self.verifyInput becomeFirstResponder];
    }
    else if(textField.tag == VMMTag)
    {
        [self.nickNameInput becomeFirstResponder];
        if (!is4InchScreen())
        {
        [self.bgScrollView setContentOffset:CGPointMake(0, 230) animated:YES];
        }
    }
    else if(textField.tag == NickNameTag)
    {
    }
    return YES;
}

- (void)textFieldDidEndEditing:(FAInputView *)textField
{
    if (textField.tag ==EmailTag
        && ![textField.textField.text validateEmailAddress]
        ) {
        [self showWarning:@"邮箱格式错误"];
        [textField setState:NO];
    }
    else if (textField.tag == MMTag) {
        
    }
    else if (textField.tag == VMMTag){
     if(![textField.textField.text isEqualToString:_mmInput.textField.text])
     {
         [self showWarning:@"密码不匹配啊"];
         [_mmInput setState:NO];
         [_verifyInput setState:NO];
     }
    }
}



@end

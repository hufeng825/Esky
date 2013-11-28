//
//  ESModifyPassWordViewController.m
//  Esquire
//
//  Created by jason on 13-11-19.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESModifyPassWordViewController.h"
#import "UIViewController+KNSemiModal.h"

@interface ESModifyPassWordViewController ()

@end

@implementation ESModifyPassWordViewController

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
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       // [self showSuccessView];
//        [self showWarning:@"邮箱格式错误" yOffset:-40.f];
        [self.mmInput becomeFirstResponder];

    });
    

}



-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)themeChanged
{    
    [self.okBt setBackgroundImage:[[FAThemeManager sharedManager]themeImageWithName:@"bt.png"] forState:UIControlStateNormal];
    [self.successBt setBackgroundImage:[[FAThemeManager sharedManager]themeImageWithName:@"bt.png"] forState:UIControlStateNormal];
    
}



-(void)showSuccessView
{
    HFAlert(@"d");
    [self.view bringSubviewToFront:self.successView];
    [self.successView setHidden:NO];
}

- (void)resizeSemiModalViewHeight:(CGFloat) height{
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(resizeSemiView:)]) {
        [parent resizeSemiView:CGSizeMake(self.view.width,height)];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self resizeSemiModalViewHeight:440];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self resizeSemiModalViewHeight:212];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //注意此处 不然 可能导致键盘无法消退
    if (![textField.text validateEmailAddress]
        ) {
        [self showWarning:@"邮箱格式错误"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

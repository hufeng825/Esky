//
//  FABaseViewController.m
//  Esquire
//
//  Created by jason on 13-10-23.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"

@interface ESBaseViewController ()

@end

@implementation ESBaseViewController

@synthesize  hfClient;


- (id)init
{
//    NSString    *clssName = NSStringFromClass([self class]);
//    NSString    *xibName = is4InchScreen() ?[NSString stringWithFormat:@"%@_4inch", clssName] : clssName;
    NSString    *xibName = NSStringFromClass([self class]);
    
    self = [super initWithNibName:xibName bundle:nil];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeChangedNotification object:nil];

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

#pragma mark  - 返回上级页面
- (void)goBack
{
    if ([[self.navigationController viewControllers]count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


/*------------------------------------------
 *设置背景
 *------------------------------------------*/

- (void)changeBaseBackgourndColorWithImageName:(UIImage *)image
{
  
    
    UIColor *bgColor = [UIColor colorWithPatternImage:[image imageByScalingProportionallyToMinimumSize:self.view.frame.size]];
    
    
    if ([self.view isKindOfClass:[UITableView class]]) {
        UIView *viewi = [[UIView alloc] initWithFrame:self.view.bounds];
        viewi.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        viewi.backgroundColor = bgColor;
        UITableView *tView = (UITableView *)self.view;
        
        if ([tView respondsToSelector:@selector(setBackgroundView:)]) {
            [tView setBackgroundView:viewi];
        }
    }
    
    self.view.backgroundColor = bgColor;
}


- (void)themeChanged
{
   [self changeBaseBackgourndColorWithImageName:[[FAThemeManager sharedManager] themeImageWithName:@"bg@2x.jpg"]];
}
/*------------------------------------------
 *设置statubar
 *------------------------------------------*/

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad
{
    [self themeChanged];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -  网络请求
- (HFBaseHttpRequest *)hfClient
{
    if (!hfClient) {
        self.hfClient = [HFBaseHttpRequest client];
    }
    
    return hfClient;
}


- (void)postUrl         :(NSString *)url
        postArguments   :(NSDictionary *)parameters
        ResponArgument  :(HFHttpResponArguments *)responArguments
{
    [self.hfClient Url:url parameters:parameters method:POSTHttpMethod ResponArgument:responArguments];
}



- (void)gettUrl         :(NSString *)url
        ResponArgument  :(HFHttpResponArguments *)responArguments
{
    [self.hfClient Url:url parameters:nil method:GETHttpMethod ResponArgument:responArguments];
}

#pragma mark -
#pragma mark Execution code

-(void)showWarning:(NSString *)warningStr
{
    [self showWarning:warningStr yOffset:-10.f];
}

-(void)showWarning:(NSString *)warningStr yOffset:(float)yOffset
{
    MBProgressHUD * hudView= [[MBProgressHUD alloc] initWithView:self.view];
    hudView.mode = MBProgressHUDModeText;
    [self.view addSubview:hudView];
    hudView.labelText = warningStr;
    hudView.userInteractionEnabled = NO;
    hudView.removeFromSuperViewOnHide = YES;
    hudView.yOffset = yOffset;
    //显示对话框
    [hudView showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(1);
    } completionBlock:^{
        //操作执行完后取消对话框
        [hudView removeFromSuperview];
    }];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (void)dealloc
{
    [[hfClient operationQueue]cancelAllOperations];
}



@end

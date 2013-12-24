//
//  ESBaseViewController.m
//  Esquire
//
//  Created by jason on 13-10-23.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"

@interface ESBaseViewController ()
@property(nonatomic, readonly) UIView *statusBarBackgroundView;
@end

@implementation ESBaseViewController
@synthesize statusBarBackgroundView;


- (id)init {
    NSString *clssName = NSStringFromClass([self class]);
    NSString *xibName = is4InchScreen() ? [NSString stringWithFormat:@"%@_4inch", clssName] : clssName;

    self = [super initWithNibName:xibName bundle:nil];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeChangedNotification object:nil];

    }

    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeChangedNotification object:nil];
    }
    return self;
}

#pragma mark  - 返回上级页面
- (void)goBack {
    if ([[self.navigationController viewControllers] count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


/*------------------------------------------
 *设置背景
 *------------------------------------------*/

- (void)changeBaseBackgourndColorWithImageName:(UIImage *)image {


    if ([self.view isKindOfClass:[UITableView class]]) {
        UIView *viewi = [[UIView alloc] initWithFrame:self.view.bounds];
        viewi.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        viewi.layer.contents = (id) image.CGImage;
        UITableView *tView = (UITableView *) self.view;

        if ([tView respondsToSelector:@selector(setBackgroundView:)]) {
            [tView setBackgroundView:viewi];
        }
    }

    self.view.layer.contents = (id) image.CGImage;
}


- (void)themeChanged {
    [self changeBaseBackgourndColorWithImageName:[[FAThemeManager sharedManager] themeImageWithName:@"bg.png"]];
    UIColor *nvBartintColor = [[FAThemeManager sharedManager] themeColorWithName:@"kIconColor"];
    [self.navigationController.navigationBar setTintColor:nvBartintColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, .3);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : nvBartintColor, NSShadowAttributeName : shadow, NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0]}];
//    [self.navigationController.navigationBar setNeedsDisplay];
}

/*------------------------------------------
 *设置statubar
 *------------------------------------------*/

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [self themeChanged];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark Execution code

- (void)showWarning:(NSString *)warningStr {
    [self showWarning:warningStr yOffset:-10.f];
}

- (void)showWarning:(NSString *)warningStr yOffset:(float)yOffset {
    MBProgressHUD *hudView = [[MBProgressHUD alloc] initWithView:self.view];
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
    }     completionBlock:^{
        //操作执行完后取消对话框
        [hudView removeFromSuperview];
    }];
}


- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

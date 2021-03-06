//
//  FAAppDelegate.m
//  FAFrame
//
//  Created by jason on 13-10-22.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESAppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboApi.h"
#import "WXApi.h"

#import "FAThemeManager.h"
#import "YASlidingViewController.h"

//#import "MSDynamicsDrawerViewController.h"

#import "ESLoginViewController.h"


@implementation ESAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     打开键盘监控
     */

    //    [IQKeyBoardManager installKeyboardManager];

    [self themeFunction];

    /**
     注册SDK应用，此应用请到http://www.sharesdk.cn中进行注册申请。
     此方法必须在启动时调用，否则会限制SDK的使用。
     **/
    [ShareSDK registerApp:@"iosv1101"];


    [self initializePlat];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    self.tabViewController = [[HFTabBarViewController alloc] initWithNibName:@"HFTabBarViewController" bundle:nil];
    self.tabViewController.delegate = self;
    
    

    
    
    self.leftMenuViewController = [[ESLeftMenuViewController alloc]initWithNibName:@"ESLeftMenuViewController" bundle:Nil];
    
    
    
    YASlidingViewController *slidingViewController = [YASlidingViewController new];
    slidingViewController.peakAmount = 200.0f;
    slidingViewController.leftViewController = _leftMenuViewController;
    
    slidingViewController.topViewController = _tabViewController;
    
    self.manViewController = [[ESMainViewController alloc] initDrawerViewController:slidingViewController];
    self.showCenterViewController = [[ESShowCenterViewController alloc] initDrawerViewController:slidingViewController];
    
    
    ESLoginViewController *vc = [[ESLoginViewController alloc]initWithNibName:@"ESLoginViewController" bundle:nil];
    
    self.skillHomeViewController = [[ESSkillHomeViewController alloc]initDrawerViewController:slidingViewController];
    
    
    
    ESFollowViewController *follow = [[ESFollowViewController alloc]initDrawerViewController:slidingViewController];
    
    
    [self.tabViewController setSubViewControllers:@[_manViewController,_skillHomeViewController,follow,_showCenterViewController,vc]];
    self.tabViewController.selectedIndex =0;

    
    
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:slidingViewController];
    [slidingViewController.navigationController setNavigationBarHidden:YES];
    
    
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
 

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];

    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back@2x.png"]];




    //    UIImageView *splashScreen = [[[UIImageView alloc] initWithFrame:self.window.bounds] autorelease];
    //    splashScreen.image = [UIImage imageNamed:@"Default"];
    //    [self.window addSubview:splashScreen];
    //    [NSThread sleepForTimeInterval:1.0];
    //    [UIView animateWithDuration:1.0 animations:^{
    //        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
    //        splashScreen.layer.transform = transform;
    //        splashScreen.alpha = 0.0;
    //    } completion:^(BOOL finished) {
    //        [splashScreen removeFromSuperview];
    //    }];

    return YES;

}

- (void)tabBarController:(HFTabBarViewController *)tabBarController
    selectViewController:(UIViewController *)viewController
                 atIndex:(HFTabBarIndex *)index
{
    if (index.toIndex != 0) {
//        _manViewController 
    }
}

- (void)initializePlat {
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //连接短信分享
    [ShareSDK connectSMS];
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];


//    //连接邮件
//    [ShareSDK connectMail];
//
//    //连接打印
//    [ShareSDK connectAirPrint];
//
//    //连接拷贝
//    [ShareSDK connectCopy];

}

/**
 *	@brief	托管模式下的初始化平台
 */
- (void)initializePlatForTrusteeship {
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];


    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];

    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
    [ShareSDK importWeChatClass:[WXApi class]];
}

//主题设置

- (void)themeFunction {
    NSString *lastSaveTheme = [USER_DEFAULT objectForKey:kThemeChangedNotification];
    if (!TTIsStringWithAnyText(lastSaveTheme)) {
        [[FAThemeManager sharedManager] setThemeName:@"man"];
    }
    else if (![[[FAThemeManager sharedManager] themeName]
            isEqualToString:lastSaveTheme]) {
        [[FAThemeManager sharedManager] setThemeName:lastSaveTheme];
    }

}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self themeFunction];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

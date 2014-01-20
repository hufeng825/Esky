//
//  ESAppDelegate.h
//  EskyApp
//
//  Created by jason on 13-11-27.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTabBarViewController.h"
#import "ESLeftMenuViewController.h"
#import "ESMainViewController.h"
#import "ESShowCenterViewController.h"
#import "ESSkillHomeViewController.h"


@interface ESAppDelegate : UIResponder <UIApplicationDelegate,HFTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HFTabBarViewController *tabViewController;
@property (strong, nonatomic) ESLeftMenuViewController *leftMenuViewController;
@property (strong, nonatomic) ESMainViewController *manViewController;
@property (strong, nonatomic) ESShowCenterViewController *showCenterViewController;
@property (strong, nonatomic) ESSkillHomeViewController *skillHomeViewController;


@end

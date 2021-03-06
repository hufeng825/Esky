//
//  iCarouselTypeRotary.h
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YASlidingViewController.h"
#import "ESBaseViewController.h"
#import "ESMenuTabBar.h"
#import "ESPictureItem.h"


@interface ESShowCenterViewController :ESBaseViewController<ESMenuTabBarDelegate>

@property (nonatomic, weak) YASlidingViewController *dynamicsDrawerViewController;

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController;

@end
